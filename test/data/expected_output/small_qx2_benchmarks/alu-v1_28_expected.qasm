//Note: initial mapping (logical qubit at each location): 2, 1, 4, 3, 0, 
//Note: initial mapping (location of each logical qubit): 4, 1, 0, 3, 2, 
OPENQASM 2.0;
include "qelib1.inc";
qreg q[5];
creg c[5];
cx q[2],q[3]; //cycle: 0 //cx q[4],q[3]
cx q[1],q[0]; //cycle: 0 //cx q[1],q[2]
cx q[0],q[2]; //cycle: 2 //cx q[2],q[4]
h q[1]; //cycle: 2 //h q[1]
t q[3]; //cycle: 2 //t q[3]
t q[1]; //cycle: 3 //t q[1]
t q[2]; //cycle: 4 //t q[4]
t q[0]; //cycle: 4 //t q[2]
cx q[0],q[2]; //cycle: 5 //cx q[2],q[4]
cx q[1],q[0]; //cycle: 7 //cx q[1],q[2]
cx q[2],q[1]; //cycle: 9 //cx q[4],q[1]
tdg q[0]; //cycle: 9 //tdg q[2]
cx q[2],q[0]; //cycle: 11 //cx q[4],q[2]
t q[1]; //cycle: 11 //t q[1]
swap q[1],q[2]; //cycle: 13
tdg q[0]; //cycle: 13 //tdg q[2]
cx q[2],q[0]; //cycle: 19 //cx q[1],q[2]
tdg q[1]; //cycle: 19 //tdg q[4]
cx q[1],q[2]; //cycle: 21 //cx q[4],q[1]
cx q[0],q[1]; //cycle: 23 //cx q[2],q[4]
h q[2]; //cycle: 23 //h q[1]
cx q[2],q[4]; //cycle: 24 //cx q[1],q[0]
h q[2]; //cycle: 26 //h q[1]
t q[4]; //cycle: 26 //t q[0]
cx q[3],q[4]; //cycle: 27 //cx q[3],q[0]
t q[2]; //cycle: 27 //t q[1]
cx q[2],q[3]; //cycle: 29 //cx q[1],q[3]
cx q[4],q[2]; //cycle: 31 //cx q[0],q[1]
tdg q[3]; //cycle: 31 //tdg q[3]
cx q[4],q[3]; //cycle: 33 //cx q[0],q[3]
t q[2]; //cycle: 33 //t q[1]
tdg q[4]; //cycle: 35 //tdg q[0]
tdg q[3]; //cycle: 35 //tdg q[3]
cx q[2],q[3]; //cycle: 36 //cx q[1],q[3]
cx q[4],q[2]; //cycle: 38 //cx q[0],q[1]
cx q[3],q[4]; //cycle: 40 //cx q[3],q[0]
h q[2]; //cycle: 40 //h q[1]
x q[2]; //cycle: 41 //x q[1]
//37 original gates
//38 gates in generated circuit
//37 ideal depth (cycles)
//42 depth of generated circuit
//555 nodes popped from queue for processing.
//975 nodes remain in queue.
//HashFilter filtered 2192 total nodes.
//HashFilter2 filtered 229 total nodes.
//HashFilter2 marked 367 total nodes.
