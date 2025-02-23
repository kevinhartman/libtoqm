#ifndef CXFRONTIER_HPP
#define CXFRONTIER_HPP

#include "libtoqm/CostFunc.hpp"
#include "libtoqm/Node.hpp"

#include <cassert>

namespace toqm {

class CXFrontier : public CostFunc {
public:
	int _getCost(Node& node) const override {
		//bool debug = node.cost > 0;//called getCost for second time on this node
		
		int cost = 0;
		int costT = 99999;
		Environment & env = node.env;
		auto next2BitGate = std::vector<GateNode *>(env.numPhysicalQubits);
		auto pathLength = std::vector<int>(env.numPhysicalQubits);
		for(int x = 0; x < env.numPhysicalQubits; x++) {
			next2BitGate[x] = NULL;
			pathLength[x] = 0;
			int busy = node.busyCycles(x);
			if(busy > cost) {
				cost = busy;
			}
		}
		
		//search from last scheduled (non-swap) gates
		for(int x = 0; x < env.numPhysicalQubits; x++) {
			auto sg = node.lastNonSwapGate[x];
			if(sg) {
				//get latest physical location of logical qubit x:
				int actualQubit;
				if(sg->gate->target == x) {
					actualQubit = node.laq[sg->gate->target];
				} else {
					assert(sg->gate->control == x);
					actualQubit = node.laq[sg->gate->control];
				}
				
				//get path length to next 2-qubit gate along this qubit:
				pathLength[actualQubit] = node.busyCycles(actualQubit);
				if(!pathLength[actualQubit]) {
					pathLength[actualQubit] = 1;//since we won't schedule any more gates this cycle
				}
				GateNode * temp;
				if(sg->gate->target == x) {
					temp = sg->gate->targetChild;
				} else {
					assert(sg->gate->control == x);
					temp = sg->gate->controlChild;
				}
				
				while(temp && temp->control < 0) {
					pathLength[actualQubit] += temp->optimisticLatency;
					temp = temp->targetChild;
				}
				next2BitGate[actualQubit] = temp;
			}
		}
		
		//also search from ready gates, in case some qubits haven't scheduled gates yet
		auto iter = node.readyGates.begin();
		while(iter != node.readyGates.end()) {
			GateNode * g = *iter;
			int physicalTarget = node.laq[g->target];
			
			if(physicalTarget < 0) {
				iter++;
				continue;
			}
			
			if(g->control < 0) {
				//if(next2BitGate[physicalTarget] == NULL) {
					pathLength[physicalTarget] = node.busyCycles(physicalTarget);
					if(!pathLength[physicalTarget]) {
						pathLength[physicalTarget] = 1;//since we won't schedule any more gates this cycle
					}
					GateNode * temp = g;
					while(temp && temp->control < 0) {
						pathLength[physicalTarget] += temp->optimisticLatency;
						temp = temp->targetChild;
					}
					next2BitGate[physicalTarget] = temp;
					
					if(temp) {
						int otherBit;
						bool noOtherParent = false;
						if(temp->target == g->target) {
							noOtherParent = temp->controlParent == NULL;
							otherBit = node.laq[temp->control];
						} else {
							assert(temp->control == g->target);
							noOtherParent = temp->targetParent == NULL;
							otherBit = node.laq[temp->target];
						}
						if(noOtherParent && next2BitGate[otherBit] == NULL) {
							next2BitGate[otherBit] = temp;
							pathLength[otherBit] = node.busyCycles(otherBit);
							if(!pathLength[otherBit]) {
								pathLength[otherBit] = 1;//since we won't schedule any more gates this cycle
							}
						}
					}
				//}
			} else {
				int physicalControl = node.laq[g->control];
				if(physicalControl < 0) {
					iter++;
					continue;
				}
				assert(next2BitGate[physicalControl] == g || next2BitGate[physicalControl] == NULL);
				assert(next2BitGate[physicalTarget] == g || next2BitGate[physicalTarget] == NULL);
				
				pathLength[physicalTarget] = node.busyCycles(physicalTarget);
				if(!pathLength[physicalTarget]) {
					pathLength[physicalTarget] = 1;//since we won't schedule any more gates this cycle
				}
				next2BitGate[physicalTarget] = g;
				
				pathLength[physicalControl] = node.busyCycles(physicalControl);
				if(!pathLength[physicalControl]) {
					pathLength[physicalControl] = 1;//since we won't schedule any more gates this cycle
				}
				next2BitGate[physicalControl] = g;
			}
			
			iter++;
		}
		
		//analyze cnot frontier
		for(int x = 0; x < env.numPhysicalQubits - 1; x++) {
			GateNode * g = next2BitGate[x];
			if(g) {
				//if(debug) std::cerr << "  considering next gate for physical qubit " << x << "\n";
				//if(debug) std::cerr << "   logical qubits: " << g->control << "," << g->target << "\n";
				int physicalTarget = node.laq[g->target];
				int physicalControl = node.laq[g->control];
				
				//if(debug) std::cerr << "   physical qubits: " << physicalControl << "," << physicalTarget << "\n";
				
				assert(physicalTarget == x || physicalControl == x);
				assert(physicalTarget != physicalControl);
				//assert(physicalTarget >= 0 && physicalControl >= 0);
				if(physicalTarget < 0 || physicalControl < 0) {
					continue;
				}
				
				int length1 = pathLength[physicalTarget];
				int length2 = pathLength[physicalControl];
				
				bool skipCheckedCheck = false;
				
				if(next2BitGate[physicalTarget] == NULL && g->targetParent == NULL) {
					next2BitGate[physicalTarget] = g;
					length1 = node.busyCycles(physicalTarget);
					if(!length1) {
						length1 = 1;//since we won't schedule any more gates this cycle
					}
					skipCheckedCheck = true;
				}
				
				if(next2BitGate[physicalControl] == NULL && g->controlParent == NULL) {
					next2BitGate[physicalControl] = g;
					length2 = node.busyCycles(physicalControl);
					if(!length2) {
						length2 = 1;//since we won't schedule any more gates this cycle
					}
					skipCheckedCheck = true;
				}
				
				//skip if this cnot depends on another unscheduled cnot
				if(next2BitGate[physicalTarget] != next2BitGate[physicalControl]) {
					//if(debug) std::cerr << "   skipping (non-frontier)\n";
					continue;
				}
				
				//skip if we already processed this in earlier iteration:
				if(!skipCheckedCheck && physicalTarget <= x && physicalControl <= x) {
					//if(debug) std::cerr << "   skipping (already checked)\n";
					continue;
				}
				
				int minSwaps = env.couplingDistances[physicalControl * env.numPhysicalQubits + physicalTarget] - 1;
				if(minSwaps < costT) costT = minSwaps;
				int totalSwapCost = env.swapCost * minSwaps;
				
				if(length1 < length2) {
					std::swap(length1, length2);
				}
				
				//if(debug) std::cerr << "   path lengths: " << length1 << "," << length2 << "\n";
				//if(debug) std::cerr << "   swaps needed at least: " << minSwaps << "\n";
				
				int slack = length1 - length2;
				int effectiveSlack = (slack / env.swapCost) * env.swapCost;
				if(effectiveSlack > totalSwapCost) {
					effectiveSlack = totalSwapCost;
				}
				
				//if(debug) std::cerr << "   effective slack cycles: " << effectiveSlack << "\n";
				
				int mutualSwapCost = totalSwapCost - effectiveSlack;
				int extraSwapCost = (0x1 & (mutualSwapCost / env.swapCost)) * env.swapCost;
				mutualSwapCost -= extraSwapCost;
				assert((mutualSwapCost % env.swapCost) == 0);
				mutualSwapCost = mutualSwapCost >> 1;
				
				int cost1 = g->optimisticLatency + g->criticality + length1 + mutualSwapCost;
				int cost2 = g->optimisticLatency + g->criticality + length2 + mutualSwapCost + effectiveSlack;
				
				if(cost1 < cost2) {
					cost1 += extraSwapCost;
				} else {
					cost2 += extraSwapCost;
				}
				
				//if(debug) std::cerr << "   shared swap cycles: " << mutualSwapCost << "\n";
				//if(debug) std::cerr << "   criticality: " << g->criticality << "\n";
				
				//if(debug) std::cerr << "   subcircuit cost: " << cost1 << " vs " << cost2 << "\n";
				
				if(cost1 > cost) {
					cost = cost1;
				}
				if(cost2 > cost) {
					cost = cost2;
				}
			}
		}
		
		//add old cycles to cost
		cost += node.cycle;
		
		if(costT == 99999) costT = 0;
		node.cost2 = costT;
		
		return cost;
	}
	
	std::unique_ptr<CostFunc> clone() const override {
		return std::unique_ptr<CostFunc>(new CXFrontier(*this));
	}
};

}

#endif
