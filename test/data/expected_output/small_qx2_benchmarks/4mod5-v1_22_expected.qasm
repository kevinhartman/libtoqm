//Note: initial mapping (logical qubit at each location): 2, 4, 0, 1, 3, 
//Note: initial mapping (location of each logical qubit): 2, 3, 0, 4, 1, 
OPENQASM 2.0;
include "qelib1.inc";
qreg q[5];
creg c[5];
cx q[2],q[0]; //cycle: 0 //cx q[0],q[2]
cx q[3],q[4]; //cycle: 0 //cx q[1],q[3]
x q[1]; //cycle: 0 //x q[4]
h q[1]; //cycle: 1 //h q[4]
t q[0]; //cycle: 2 //t q[2]
t q[4]; //cycle: 2 //t q[3]
t q[1]; //cycle: 2 //t q[4]
swap q[2],q[4]; //cycle: 3
cx q[2],q[0]; //cycle: 9 //cx q[3],q[2]
cx q[1],q[2]; //cycle: 11 //cx q[4],q[3]
cx q[0],q[1]; //cycle: 13 //cx q[2],q[4]
tdg q[2]; //cycle: 13 //tdg q[3]
cx q[0],q[2]; //cycle: 15 //cx q[2],q[3]
t q[1]; //cycle: 15 //t q[4]
tdg q[0]; //cycle: 17 //tdg q[2]
tdg q[2]; //cycle: 17 //tdg q[3]
cx q[1],q[2]; //cycle: 18 //cx q[4],q[3]
cx q[0],q[1]; //cycle: 20 //cx q[2],q[4]
cx q[2],q[0]; //cycle: 22 //cx q[3],q[2]
h q[1]; //cycle: 22 //h q[4]
cx q[0],q[2]; //cycle: 24 //cx q[2],q[3]
cx q[2],q[1]; //cycle: 26 //cx q[3],q[4]
//21 original gates
//22 gates in generated circuit
//22 ideal depth (cycles)
//28 depth of generated circuit
//794 nodes popped from queue for processing.
//1073 nodes remain in queue.
//HashFilter filtered 1549 total nodes.
//HashFilter2 filtered 503 total nodes.
//HashFilter2 marked 723 total nodes.