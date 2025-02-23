#ifndef DEFAULTPLUSINITIAL_HPP
#define DEFAULTPLUSINITIAL_HPP

#include "libtoqm/Expander.hpp"
#include "libtoqm/Queue.hpp"
#include "libtoqm/CostFunc.hpp"

#include <cassert>
#include <vector>
#include <iostream>

namespace toqm {

class NoSwaps : public Expander {
private:
	static int busyCycles(const Node& n, int logicalQubit) {
		if(!n.lastNonSwapGate[logicalQubit]) return 0;
		int cycles = n.lastNonSwapGate[logicalQubit]->cycle + n.lastNonSwapGate[logicalQubit]->latency - n.cycle;
		if(cycles < 0) return 0;
		return cycles;
	}

public:
	bool expand(Queue& nodes, const std::shared_ptr<Node>& node) const override {
		//return false if we're done expanding
		if(nodes.getBestFinalNode() && node->cost >= nodes.getBestFinalNode()->cost) {
			return false;
		}
		
		//unset initial mapping for root node
		if(node->parent == NULL) {
			for(int x = 0; x < node->env.numLogicalQubits; x++) {
				node->laq[x] = -1;
				node->qal[x] = -1;
			}
		}
		
		//if this node has any unmapped qubits affecting frontier, make alternate nodes where they're mapped:
		bool addedNodes = false;
		auto & n = node;
		Environment & env = node->env;
		for(auto iter = n->readyGates.begin(); iter != n->readyGates.end(); iter++) {
			if(addedNodes) {
				//just let the child nodes handle the next one:
				break;
			}
			
			int numAdded = 0;
			
			GateNode * g = *iter;
			//GateNode * g = env.firstCXPerQubit[z];
			
			if(g && g->control < 0) {
				g = g->nextTargetCNOT ? g->nextTargetCNOT : g;
			}
			
			if(g && g->control >= 0) {
				int physC = n->laq[g->control];
				int physT = n->laq[g->target];
				if(physC < 0 && physT < 0) {
					addedNodes = true;
					for(unsigned int x = 0; x < env.couplings.size(); x++) {
						GateNode * sw = env.possibleSwaps[x];
						if(n->qal[sw->control] < 0 && n->qal[sw->target] < 0) {
							std::shared_ptr<Node> n1 = Node::prepChild(n);
							n1->cycle--;
							n1->laq[g->control] = sw->control;
							n1->laq[g->target] = sw->target;
							n1->qal[sw->control] = g->control;
							n1->qal[sw->target] = g->target;
							n1->cost = n->cost - 1;//env.cost->getCost(n1);
							if(nodes.push(n1)) {
								numAdded++;
							}
							
							std::shared_ptr<Node> n2 = Node::prepChild(n);
							n2->cycle--;
							n2->laq[g->control] = sw->target;
							n2->laq[g->target] = sw->control;
							n2->qal[sw->control] = g->target;
							n2->qal[sw->target] = g->control;
							n2->cost = n->cost - 1;//env.cost->getCost(n2);
							if(nodes.push(n2)) {
								numAdded++;
							}
						}
					}
				} else if(physC < 0) {
					addedNodes = true;
					for(unsigned int x = 0; x < env.couplings.size(); x++) {
						auto & sw = env.possibleSwaps[x];
						if(n->qal[sw->control] < 0 && n->qal[sw->target] == g->target) {
							std::shared_ptr<Node> n1 = Node::prepChild(n);
							n1->cycle--;
							n1->laq[g->control] = sw->control;
							n1->qal[sw->control] = g->control;
							assert(n1->laq[g->target] == sw->target);
							n1->cost = n->cost - 1;//env.cost->getCost(n1);
							if(nodes.push(n1)) {
								numAdded++;
							}
						} else if(n->qal[sw->target] < 0 && n->qal[sw->control] == g->target) {
							std::shared_ptr<Node> n1 = Node::prepChild(n);
							n1->cycle--;
							n1->laq[g->control] = sw->target;
							n1->qal[sw->target] = g->control;
							assert(n1->laq[g->target] == sw->control);
							n1->cost = n->cost - 1;//env.cost->getCost(n1);
							if(nodes.push(n1)) {
								numAdded++;
							}
						}
					}
				} else if(physT < 0) {
					addedNodes = true;
					for(unsigned int x = 0; x < env.couplings.size(); x++) {
						auto & sw = env.possibleSwaps[x];
						if(n->qal[sw->control] < 0 && n->qal[sw->target] == g->control) {
							std::shared_ptr<Node> n1 = Node::prepChild(n);
							n1->cycle--;
							n1->laq[g->target] = sw->control;
							n1->qal[sw->control] = g->target;
							assert(n1->laq[g->control] == sw->target);
							n1->cost = n->cost - 1;//env.cost->getCost(n1);
							if(nodes.push(n1)) {
								numAdded++;
							}
						} else if(n->qal[sw->target] < 0 && n->qal[sw->control] == g->control) {
							std::shared_ptr<Node> n1 = Node::prepChild(n);
							n1->cycle--;
							n1->laq[g->target] = sw->target;
							n1->qal[sw->target] = g->target;
							assert(n1->laq[g->control] == sw->control);
							n1->cost = n->cost - 1;//env.cost->getCost(n1);
							if(nodes.push(n1)) {
								numAdded++;
							}
						}
					}
				}
			}
		}
		if(addedNodes) {
			return true;
		}
		
		std::vector<GateNode*> possibleGates;//executable ready gates
		for(auto iter = node->readyGates.begin(); iter != node->readyGates.end(); iter++) {
			auto & g = *iter;
			int target = g->target;
			int control = g->control;
			
			bool good = (node->cycle >= -1);
			
			if(good && target >= 0 && node->lastNonSwapGate[target]) {
				if(busyCycles(*node, target) > 1) {
					good = false;
				}
			}
			
			if(good && control >= 0 && node->lastNonSwapGate[control]) {
				if(busyCycles(*node, control) > 1) {
					good = false;
				}
			}
			
			//if 2-qubit gate, make sure it's actually executable:
			if(good && control >= 0 && target >= 0) {//gate has 2 qubits
				int physicalTarget = node->laq[target];
				int physicalControl = node->laq[control];
				if(node->env.couplings.count(std::make_pair(physicalTarget, physicalControl)) <= 0) {
					if(node->env.couplings.count(std::make_pair(physicalControl, physicalTarget)) <= 0) {
						good = false;
					}
				}
			}
			
			if(good) {
				possibleGates.push_back(g);
			}
		}
		
		std::shared_ptr<Node> child = Node::prepChild(node);
		int numgatesscheduled = 0;
		
		//schedule the gates
		for(auto & possibleGate : possibleGates) {
			if(node->cycle >= -1) {
				assert(child->scheduleGate(possibleGate));
				numgatesscheduled++;
			} else {
				assert(false);
			}
		}
		
		bool good = true;
		if(!numgatesscheduled) {
			int numbusy = 0;
			for(int x = 0; x < node->env.numLogicalQubits; x++) {
				if(busyCycles(*child, x) > 0) {
					numbusy++;
				}
			}
			if(!numbusy) {
				good = false;
			}
		}
		
		if(good) {
			child->cost = node->cost - numgatesscheduled;//node->env.cost->getCost(child);
			nodes.push(child);
		}
		
		return true;
	}
	
	std::unique_ptr<Expander> clone() const override {
		return std::unique_ptr<Expander>(new NoSwaps(*this));
	}
};

}

#endif
