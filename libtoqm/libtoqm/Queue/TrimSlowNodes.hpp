#ifndef TRIM_SLOW_NODES_HPP
#define TRIM_SLOW_NODES_HPP

#include "libtoqm/Queue.hpp"

#include <queue>
#include <vector>
#include <iostream>

namespace toqm {

extern bool _verbose;

/**
 * This queue uses std::priority_queue for its underlying structure.
 * Whenever this queue reaches a specified max size,
	it deletes the slowest nodes until the queue reaches its target size.
 */
class TrimSlowNodes : public Queue {
private:
	unsigned int maxSize = 1000;
	unsigned int targetSize = 500;
	
	struct CmpCost {
		bool operator()(const std::shared_ptr<Node>& lhs, const std::shared_ptr<Node>& rhs) const {
			//tiebreaker:
			if(lhs->cost == rhs->cost) {
				//return lhs->scheduled->size > rhs->scheduled->size;
				//return lhs->numUnscheduledGates > rhs->numUnscheduledGates;
				//return lhs->cycle < rhs->cycle;
			}
			
			//lower cost is better
			return lhs->cost > rhs->cost;
		}
	};
	
	struct CmpProgress {
		bool operator()(const std::shared_ptr<Node>& lhs, const std::shared_ptr<Node>& rhs) const {
			//tiebreaker:
			if(lhs->numUnscheduledGates == rhs->numUnscheduledGates) {
				return lhs->cost > rhs->cost;
			}
			
			//fewer not-yet-scheduled gates is better
			return lhs->numUnscheduledGates > rhs->numUnscheduledGates;
		}
	};
	
	/**
	 * The queue containing the nodes
	 */
	std::priority_queue<std::shared_ptr<Node>, std::vector<std::shared_ptr<Node>>, CmpCost> nodes;
	
	/**
	 * A temporary queue used to organize nodes by progress through the original circuit
	 */
	std::priority_queue<std::shared_ptr<Node>, std::vector<std::shared_ptr<Node>>, CmpProgress> tempQueue;
	
	bool pushNode(const std::shared_ptr<Node>& newNode) override {
		nodes.push(newNode);
		if(_verbose) {
			if(newNode->numUnscheduledGates < garbage) {
				garbage = newNode->numUnscheduledGates;
				garbage2 = newNode->cost;
				
				std::cerr << "dbg More progress!\n";
				std::cerr << " " << garbage << " gates remain!\n";
				std::cerr << " cost is " << newNode->cost << "\n";
				if(newNode->parent)
					std::cerr << " parent cost is " << newNode->parent->cost << "\n";
				else
					std::cerr << " root node!\n";
				std::cerr << " num ready gates is " << newNode->readyGates.size() << "\n";
			} else if(newNode->numUnscheduledGates == garbage) {
				if(newNode->cost < garbage2) {
					garbage2 = newNode->cost;
					std::cerr << "dbg Better progress!\n";
					std::cerr << " new cost is " << newNode->cost << "\n";
				}
			}
		}
		
		if(nodes.size() > maxSize) {
			if(_verbose) {
				std::cerr << "dbg Queue needs trimming...\n";
			}
			
			//Move all nodes to queue that sorts them by progress
			while(!nodes.empty()) {
				tempQueue.push(nodes.top());
				nodes.pop();
			}
			//Move top nodes back to main queue
			for(unsigned int x = 0; x < this->targetSize; x++) {
				nodes.push(tempQueue.top());
				tempQueue.pop();
			}
			//Delete the rest of the nodes
			while(!tempQueue.empty()) {
				auto n = tempQueue.top();
				tempQueue.pop();
				n->env.deleteRecord(*n);
			}
		}
		
		return true;
	}
	
	int garbage = 9999999;
	int garbage2 = 9999999;

public:
	TrimSlowNodes() = default;
	
	TrimSlowNodes(unsigned int maxSize, unsigned int targetSize) {
		this->maxSize = maxSize;
		this->targetSize = targetSize;
		if(this->maxSize < this->targetSize) {
			std::swap(this->maxSize, this->targetSize);
		}
		assert(this->maxSize != this->targetSize);
	}
	
	std::shared_ptr<Node> pop() override {
		numPopped++;
		
		auto ret = nodes.top();
		nodes.pop();
		
		//std::cerr << "Debug message: popped node with cost " << ret->cost << "\n";
		//std::cerr << "Debug message: queue has size " << nodes.size() << " now.\n";
		
		if(ret->readyGates.empty()) {
			assert(ret->numUnscheduledGates == 0);
			bool done = true;
			if(done) {
				if(!bestFinalNode) {
					if(_verbose) std::cerr << "dbg msg: found a final node.\n";
					bestFinalNode = ret;
				} else if(ret->cost < bestFinalNode->cost) {
					if(_verbose) std::cerr << "dbg msg: found a better final node.\n";
					//delete bestFinalNode;
					bestFinalNode = ret;
				}
			}
		}
		
		return ret;
	}
	
	int size() override {
		return nodes.size();
	}
	
	std::unique_ptr<Queue> clone() const override {
		return std::unique_ptr<Queue>(new TrimSlowNodes(*this));
	}
};

}

#endif