#ifndef HASHFILTER2_HPP
#define HASHFILTER2_HPP

#include "libtoqm/Filter.hpp"
#include "libtoqm/Node.hpp"
#include "libtoqm/Environment.hpp"

#include <iostream>
#include <functional>
#include <memory>
#include <unordered_map>
#include <vector>

#ifndef HASH_COMBINE_FUNCTION
#define HASH_COMBINE_FUNCTION
//based on hash_combine from Boost libraries
template <class T>
inline void hash_combine(std::size_t& seed, const T& v)
{
	std::hash<T> hasher;
	seed ^= hasher(v) + 0x9e3779b9 + (seed<<6) + (seed>>2);
}
#endif

namespace toqm {

//calculate the number of cycles required for one node to catch up to the other's progress along specified qubit:
inline int catchUp(GateNode * ancestor, GateNode * descendant, int logQubit, int maxCycles) {
	int cycles = 0;
	while(cycles < maxCycles) {
		if(ancestor->target == logQubit) {
			ancestor = ancestor->targetChild;
		} else if(ancestor->control == logQubit) {
			ancestor = ancestor->controlChild;
		} else {
			assert(false && "bad qubit in filter?");
		}
		
		cycles += ancestor->optimisticLatency;
		
		if(ancestor == descendant) {
			break;
		}
	}
	return cycles;
}

inline std::size_t hashFunc2(const Node & n) {
	std::size_t hash_result = 0;
	int numQubits = n.env.numPhysicalQubits;
	
	//combine into hash: qubit map (array of integers)
	for(int x = 0; x < numQubits; x += 4) {
		unsigned int sum = 0;
		for(int y = 0; y < 4 && (x + y) < numQubits; y++) {
			sum = sum << 8;
			sum += 0xff & n.laq[x + y];
		}
		hash_combine(hash_result, sum);
		
		hash_combine(hash_result, n.qal[x]);//added this to try to discourage hash conflict
	}
	
	//Note: this line may avoid hash conflicts in some benchmarks?
	//if(numQubits > 4) hash_combine(hash_result, (int)(n->laq[1]+1)*(int)(n->laq[2]+1)*(int)(n->laq[3]+1)*((int)n->laq[4]+1));
	
	//adding part of cycle to hash means we filter fewer nodes, but the filter runs much faster:
	hash_combine(hash_result, n.cycle >> 3);
	
	return hash_result;
}

class HashFilter2 : public Filter {
private:
	int numFiltered = 0;
	int numMarkedDead = 0;
	bool foundConflict = false;
	std::unordered_map<std::size_t, std::vector<std::shared_ptr<Node>>> hashmap;

public:
	std::unique_ptr<Filter> createEmptyCopy() override {
		auto f = std::unique_ptr<HashFilter2>(new HashFilter2());
		f->numFiltered = this->numFiltered;
		f->numMarkedDead = this->numMarkedDead;
		return f;
	}
	
	void deleteRecord(const Node& n) override {
		std::size_t hash_result = hashFunc2(n);
		auto & mapValue = this->hashmap[hash_result];
		//assert(mapValue->size() > 0);
		for(unsigned int blah = 0; blah < mapValue.size(); blah++) {
			auto n2 = mapValue[blah];
			if(n2.get() == &n) {
				if(mapValue.size() > 1 && blah < mapValue.size() - 1) {
					std::swap(mapValue[blah], mapValue[mapValue.size() - 1]);
				}
				mapValue.pop_back();
				return;
			}
		}
		//assert(false && "hashfilter2 failed to find node to delete");
	}
	
	bool filter(const std::shared_ptr<Node>& newNode) override {
		//if(newNode->parent && newNode->parent->dead) {
		//	return true;
		//}
		
		int numQubits = newNode->env.numPhysicalQubits;
		
		std::size_t hash_result = hashFunc2(*newNode);
		
		int swapCost = newNode->env.swapCost;
		auto & mapValue = this->hashmap[hash_result];
		for(unsigned int blah = mapValue.size() - 1; blah < mapValue.size() && blah >= 0; blah--) {
			auto candidate = mapValue[blah];
			
			//if there's a very big gap between nodes' progress then we probably won't benefit from comparing them:
			//if(candidate->cycle - newNode->cycle >= 6 || newNode->cycle - candidate->cycle >= 6) {
			//	continue;
			//}
			
			if(candidate->dead) {
				continue;
			} //else if(candidate->parent && candidate->parent->dead) {
			//	candidate->dead = true;
			//}
			
			bool willFilter = candidate->cycle <= newNode->cycle;
			bool willMarkDead = newNode->cycle <= candidate->cycle;
			bool canMarkDead = false;
			
			int cycleDiff = newNode->cycle - candidate->cycle;
			if(cycleDiff < 0) {
				cycleDiff = -cycleDiff;
			}
			
			///*
			//check for simple descendant relationship (without additional gates)
			if(newNode->scheduled == candidate->scheduled) {
				willFilter = false;
				willMarkDead = false;
			}
			//*/
			/*
			//check for descendant relationship
			Node * tempNode = newNode;
			while(tempNode->cycle > candidate->cycle) {
				tempNode = tempNode->parent;
			}
			if(tempNode == candidate) {
				willFilter = false;
				willMarkDead = false;
			}
			//*/
			
			if(willFilter || willMarkDead) {
				if(this->foundConflict || blah == mapValue.size() - 1) {
					bool conflict = false;
					for(int x = 0; x < numQubits - 1; x++) {
						if(candidate->laq[x] != newNode->laq[x]) {
							if(!this->foundConflict) {
								std::cerr << "//WARNING: hash conflict detected.\n";
								this->foundConflict = true;
							}
							willFilter = false;
							conflict = true;
							break;
						}
					}
					if(conflict) {
						continue;
					}
				}
			}
			
			//set willFilter and willMarkDead to false as appropriate based on qubit progress
			for(int x = 0; (willFilter || willMarkDead) && x < numQubits; x++) {
				auto lastCanGate = candidate->lastNonSwapGate[x];
				auto lastNewGate = newNode->lastNonSwapGate[x];
				int qubit = newNode->laq[x];//physical qubit containing logical qubit x
				int canBusy = 0;
				int newBusy = 0;
				if(qubit >= 0) {
					canBusy = candidate->busyCycles(qubit);
					newBusy = newNode->busyCycles(qubit);
				}
				if(lastNewGate && !lastCanGate) {//newNode has scheduled gates that candidate hasn't scheduled
					//ToDo can maybe avoid setting to false here if candidate has made more progress on a high-latency swap?
					willFilter = false;
					canMarkDead = true;
					//ToDo can probably be more selective here too:
					if(newBusy > 1 && candidate->cycle + canBusy < newNode->cycle + newBusy) {
						willMarkDead = false;
					}
				} else if(lastCanGate && !lastNewGate) {//candidate has more scheduled gates for this qubit
					//ToDo can maybe avoid setting to false here if newNode has made more progress on a high-latency swap?
					willMarkDead = false;
					//ToDo can probably be more selective here too:
					if(canBusy > 1 && newNode->cycle + newBusy < candidate->cycle + canBusy) {
						willFilter = false;
					}
				} else if((lastCanGate && lastNewGate) || (!lastCanGate && !lastNewGate)) {
					if(!lastCanGate ||
					   lastCanGate->gate == lastNewGate->gate) {//same (un)scheduled gates for this qubit
						//compare busyness
						if(qubit >= 0) {
							if((willFilter || !canMarkDead) && canBusy > 1) {
								if(newBusy) {//both nodes are busy
									int candidateCycle = canBusy + candidate->cycle;
									int newCycle = newBusy + newNode->cycle;
									if(candidateCycle > newCycle) {
										willFilter = false;
										canMarkDead = true;
									}
								} else {//only candidate is busy
									int candidateCycle = canBusy + candidate->cycle;
									if(candidateCycle > newNode->cycle) {
										willFilter = false;
										canMarkDead = true;
									}
								}
							}
							if(willMarkDead && newBusy > 1) {
								if(canBusy) {//both nodes are busy
									int candidateCycle = canBusy + candidate->cycle;
									int newCycle = newBusy + newNode->cycle;
									if(newCycle > candidateCycle) {
										willMarkDead = false;
									}
								} else {//only newNode is busy
									int newCycle = newBusy + newNode->cycle;
									if(newCycle > candidate->cycle) {
										willMarkDead = false;
									}
								}
							}
						}
					} else if(lastCanGate->gate->criticality >
							  lastNewGate->gate->criticality) {//newNode has scheduled gates candidate hasn't
						if(willFilter &&
						   (newBusy <= 1 || newBusy <= canBusy || newNode->cycle - candidate->cycle >= swapCost)) {
							willFilter = false;
							canMarkDead = true;
						} else {
							///*
							int catchup = catchUp(lastCanGate->gate, lastNewGate->gate, x, swapCost + 1);
							//if(willFilter) {
							if(catchup + newNode->cycle + newBusy > candidate->cycle + canBusy) {
								willFilter = false;
								canMarkDead = true;
							} else if(catchup >= swapCost) {
								willFilter = false;
								canMarkDead = true;
							}
							//}
							if(willMarkDead) {
								if(catchup <= swapCost) {
									if(catchup + candidate->cycle + canBusy <= newNode->cycle + newBusy) {
										willMarkDead = false;
									}
								}
							}
							//*/
							/*
							willFilter = false;
							if(canBusy < newBusy) {
								willMarkDead = false;
							}
							//*/
						}
					} else if(lastCanGate->gate->criticality <
							  lastNewGate->gate->criticality) {//candidate has more scheduled gates for this qubit
						if(willMarkDead &&
						   (canBusy <= 1 || canBusy <= newBusy || candidate->cycle - newNode->cycle >= swapCost)) {
							willMarkDead = false;
						} else {
							///*
							int catchup = catchUp(lastNewGate->gate, lastCanGate->gate, x, swapCost + 1);
							if(willMarkDead) {
								if(catchup + candidate->cycle + canBusy > newNode->cycle + newBusy) {
									willMarkDead = false;
								} else if(catchup >= swapCost) {
									willMarkDead = false;
								}
							}
							//if(willFilter) {
							if(catchup <= swapCost) {
								if(catchup + newNode->cycle + newBusy <= candidate->cycle + canBusy) {
									willFilter = false;
									canMarkDead = true;
								}
							}
							//}
							//*/
							/*
							if(newBusy < canBusy) {
								willFilter = false;
							}
							willMarkDead = false;
							//*/
						}
					} else {
						assert(false);
					}
				} else {
					assert(false);
				}
			}
			
			if(!canMarkDead || willFilter) {
				willMarkDead = false;
			}
			if(willMarkDead) {
				candidate->dead = true;
				numMarkedDead++;
			}
			
			//remove dead node from vector
			if(candidate->dead) {
				if(mapValue.size() > 1 && blah < mapValue.size() - 1) {
					std::swap(mapValue[blah], mapValue[mapValue.size() - 1]);
				}
				mapValue.pop_back();
			}
			
			if(willFilter) {
				numFiltered++;
				return true;
			}
		}
		mapValue.push_back(newNode);
		
		return false;
	}
	
	void printStatistics(std::ostream & stream) override {
		stream << "//HashFilter2 filtered " << numFiltered << " total nodes.\n";
		stream << "//HashFilter2 marked " << numMarkedDead << " total nodes.\n";
	}
	
	std::unique_ptr<Filter> clone() const override {
		return std::unique_ptr<Filter>(new HashFilter2(*this));
	}
};

}

#endif