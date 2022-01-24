#ifndef TOQM_TOQMMAPPER_HPP
#define TOQM_TOQMMAPPER_HPP

#include "CommonTypes.hpp"

#include <string>
#include <vector>
#include <memory>
#include <set>
#include <utility>
#include <string>
#include <functional>

namespace toqm {

class Expander;

class CostFunc;

class Latency;

class Queue;

class NodeMod;

class Filter;

using QueueFactory = std::function<std::unique_ptr<Queue>()>;

class ToqmMapper {
public:
	explicit ToqmMapper(
			QueueFactory node_queue,
			std::unique_ptr<Expander> expander,
			std::unique_ptr<CostFunc> cost_func,
			std::unique_ptr<Latency> latency,
			std::vector<std::unique_ptr<NodeMod>> node_mods,
			std::vector<std::unique_ptr<Filter>> filters
	);
	
	~ToqmMapper();
	
	void setInitialSearchCycles(int initial_search_cycles);
	
	void setRetainPopped(int retain_popped);
	
	void setInitialMappingQal(const char * init_qal);
	
	void setInitialMappingLaq(const char * init_laq);
	
	void clearInitialMapping();
	
	static void setVerbose(bool verbose);
	
	// TODO: remove maxQubits. It's used internally to prealloc arrays, but we can use maps instead.
	std::unique_ptr<ToqmResult>
	run(const std::vector<GateOp> & gates, std::size_t num_qubits, const CouplingMap & coupling_map) const;

private:
	class Impl;
	
	std::unique_ptr<Impl> impl;
};

}

#endif //TOQM_TOQMMAPPER_HPP
