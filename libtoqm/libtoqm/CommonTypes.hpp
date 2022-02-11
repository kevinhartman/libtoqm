#ifndef TOQM_COMMONTYPES_HPP
#define TOQM_COMMONTYPES_HPP

#include <set>
#include <string>
#include <utility>
#include <vector>

namespace toqm {

struct CouplingMap {
	unsigned int numPhysicalQubits;
	std::set<std::pair<int, int>> edges;
};

struct GateOp {
	/**
	 * Construct a 0-qubit gate.
	 */
	GateOp(int uid, std::string type) : uid(uid), type(std::move(type)) {}
	
	/**
	 * Construct a 1-qubit gate.
	 */
	GateOp(int uid, std::string type, int target) : uid(uid), type(std::move(type)), target(target) {}
	
	/**
	 * Construct a 2-qubit gate.
	 */
	GateOp(int uid, std::string type, int control, int target) : uid(uid), type(std::move(type)), control(control), target(target) {}
	
	int uid;
	std::string type;
	int control = -1;
	int target = -1;
	
	int numQubits() const {
		return (control >= 0 ? 1 : 0) + (target >= 0 ? 1 : 0);
	}
};

struct ScheduledGateOp {
	GateOp gateOp;
	int physicalTarget;
	int physicalControl;
	int cycle; //cycle when this gate started
	int latency;
};

struct ToqmResult {
	std::vector<ScheduledGateOp> scheduledGates;
	int remainingInQueue;
	int numPhysicalQubits;
	int numLogicalQubits;
	std::vector<int> laq;
	std::vector<int> inferredQal;
	std::vector<int> inferredLaq;
	int idealCycles;
	int numPopped;
	std::string filterStats;
};

struct LatencyDescription {
	GateOp gate;
	int latency;
};

}

#endif //TOQM_COMMONTYPES_HPP
