//Note: initial mapping (logical qubit at each location): 7, 3, 0, -1, -1, 4, 5, 1, -1, -1, 6, 2, -1, -1, -1, -1, -1, -1, -1, -1, 
//Note: initial mapping (location of each logical qubit): 2, 7, 11, 1, 5, 6, 10, 0, 
OPENQASM 2.0;
include "qelib1.inc";
qreg q[20];
creg c[20];
h q[2]; //cycle: 0 //h q[0]
t q[0]; //cycle: 0 //t q[7]
t q[1]; //cycle: 0 //t q[3]
h q[7]; //cycle: 0 //h q[1]
t q[6]; //cycle: 0 //t q[5]
h q[11]; //cycle: 0 //h q[2]
t q[10]; //cycle: 0 //t q[6]
t q[5]; //cycle: 0 //t q[4]
t q[2]; //cycle: 1 //t q[0]
cx q[1],q[0]; //cycle: 1 //cx q[3],q[7]
t q[7]; //cycle: 1 //t q[1]
t q[11]; //cycle: 1 //t q[2]
cx q[2],q[1]; //cycle: 3 //cx q[0],q[3]
tdg q[1]; //cycle: 5 //tdg q[3]
swap q[0],q[1]; //cycle: 6
cx q[1],q[2]; //cycle: 12 //cx q[7],q[0]
cx q[1],q[0]; //cycle: 14 //cx q[7],q[3]
t q[2]; //cycle: 14 //t q[0]
tdg q[1]; //cycle: 16 //tdg q[7]
tdg q[0]; //cycle: 16 //tdg q[3]
swap q[0],q[1]; //cycle: 17
cx q[2],q[1]; //cycle: 23 //cx q[0],q[3]
swap q[0],q[1]; //cycle: 25
cx q[1],q[2]; //cycle: 31 //cx q[7],q[0]
cx q[0],q[1]; //cycle: 33 //cx q[3],q[7]
h q[2]; //cycle: 33 //h q[0]
h q[2]; //cycle: 34 //h q[0]
t q[1]; //cycle: 35 //t q[7]
t q[0]; //cycle: 35 //t q[3]
t q[2]; //cycle: 35 //t q[0]
cx q[6],q[1]; //cycle: 36 //cx q[5],q[7]
cx q[5],q[0]; //cycle: 36 //cx q[4],q[3]
cx q[7],q[6]; //cycle: 38 //cx q[1],q[5]
cx q[1],q[7]; //cycle: 40 //cx q[7],q[1]
tdg q[6]; //cycle: 40 //tdg q[5]
cx q[1],q[6]; //cycle: 42 //cx q[7],q[5]
t q[7]; //cycle: 42 //t q[1]
tdg q[1]; //cycle: 44 //tdg q[7]
tdg q[6]; //cycle: 44 //tdg q[5]
cx q[7],q[6]; //cycle: 45 //cx q[1],q[5]
cx q[1],q[7]; //cycle: 47 //cx q[7],q[1]
cx q[6],q[1]; //cycle: 49 //cx q[5],q[7]
h q[7]; //cycle: 49 //h q[1]
h q[7]; //cycle: 50 //h q[1]
t q[6]; //cycle: 51 //t q[5]
t q[7]; //cycle: 51 //t q[1]
t q[1]; //cycle: 51 //t q[7]
cx q[6],q[10]; //cycle: 52 //cx q[5],q[6]
cx q[11],q[6]; //cycle: 54 //cx q[2],q[5]
cx q[10],q[11]; //cycle: 56 //cx q[6],q[2]
tdg q[6]; //cycle: 56 //tdg q[5]
cx q[10],q[6]; //cycle: 58 //cx q[6],q[5]
t q[11]; //cycle: 58 //t q[2]
tdg q[10]; //cycle: 60 //tdg q[6]
tdg q[6]; //cycle: 60 //tdg q[5]
cx q[11],q[6]; //cycle: 61 //cx q[2],q[5]
swap q[5],q[6]; //cycle: 63
cx q[10],q[11]; //cycle: 63 //cx q[6],q[2]
h q[11]; //cycle: 65 //h q[2]
t q[11]; //cycle: 66 //t q[2]
cx q[5],q[10]; //cycle: 69 //cx q[5],q[6]
cx q[2],q[6]; //cycle: 69 //cx q[0],q[4]
swap q[0],q[1]; //cycle: 71
t q[10]; //cycle: 71 //t q[6]
t q[5]; //cycle: 71 //t q[5]
tdg q[6]; //cycle: 71 //tdg q[4]
cx q[5],q[10]; //cycle: 72 //cx q[5],q[6]
swap q[6],q[7]; //cycle: 73
cx q[1],q[2]; //cycle: 77 //cx q[3],q[0]
cx q[6],q[5]; //cycle: 79 //cx q[1],q[5]
cx q[1],q[7]; //cycle: 79 //cx q[3],q[4]
t q[2]; //cycle: 79 //t q[0]
cx q[10],q[6]; //cycle: 81 //cx q[6],q[1]
tdg q[5]; //cycle: 81 //tdg q[5]
tdg q[1]; //cycle: 81 //tdg q[3]
tdg q[7]; //cycle: 81 //tdg q[4]
cx q[2],q[7]; //cycle: 82 //cx q[0],q[4]
cx q[10],q[5]; //cycle: 83 //cx q[6],q[5]
t q[6]; //cycle: 83 //t q[1]
cx q[1],q[2]; //cycle: 84 //cx q[3],q[0]
tdg q[10]; //cycle: 85 //tdg q[6]
tdg q[5]; //cycle: 85 //tdg q[5]
cx q[6],q[5]; //cycle: 86 //cx q[1],q[5]
cx q[7],q[1]; //cycle: 86 //cx q[4],q[3]
h q[2]; //cycle: 86 //h q[0]
h q[2]; //cycle: 87 //h q[0]
cx q[10],q[6]; //cycle: 88 //cx q[6],q[1]
h q[7]; //cycle: 88 //h q[4]
t q[1]; //cycle: 88 //t q[3]
t q[2]; //cycle: 88 //t q[0]
t q[7]; //cycle: 89 //t q[4]
cx q[5],q[10]; //cycle: 90 //cx q[5],q[6]
h q[6]; //cycle: 90 //h q[1]
h q[6]; //cycle: 91 //h q[1]
t q[10]; //cycle: 92 //t q[6]
t q[6]; //cycle: 92 //t q[1]
x q[5]; //cycle: 92 //x q[5]
t q[5]; //cycle: 93 //t q[5]
cx q[11],q[5]; //cycle: 94 //cx q[2],q[5]
swap q[0],q[5]; //cycle: 96
swap q[6],q[11]; //cycle: 96
cx q[10],q[5]; //cycle: 102 //cx q[6],q[7]
cx q[7],q[6]; //cycle: 102 //cx q[4],q[2]
swap q[0],q[1]; //cycle: 103
cx q[11],q[10]; //cycle: 104 //cx q[1],q[6]
tdg q[6]; //cycle: 104 //tdg q[2]
cx q[5],q[11]; //cycle: 106 //cx q[7],q[1]
tdg q[10]; //cycle: 106 //tdg q[6]
cx q[5],q[10]; //cycle: 108 //cx q[7],q[6]
t q[11]; //cycle: 108 //t q[1]
cx q[1],q[7]; //cycle: 109 //cx q[5],q[4]
tdg q[5]; //cycle: 110 //tdg q[7]
tdg q[10]; //cycle: 110 //tdg q[6]
cx q[11],q[10]; //cycle: 111 //cx q[1],q[6]
cx q[1],q[6]; //cycle: 111 //cx q[5],q[2]
t q[7]; //cycle: 111 //t q[4]
cx q[5],q[11]; //cycle: 113 //cx q[7],q[1]
tdg q[1]; //cycle: 113 //tdg q[5]
tdg q[6]; //cycle: 113 //tdg q[2]
cx q[7],q[6]; //cycle: 114 //cx q[4],q[2]
cx q[10],q[5]; //cycle: 115 //cx q[6],q[7]
h q[11]; //cycle: 115 //h q[1]
cx q[1],q[7]; //cycle: 116 //cx q[5],q[4]
x q[10]; //cycle: 117 //x q[6]
t q[5]; //cycle: 117 //t q[7]
cx q[6],q[1]; //cycle: 118 //cx q[2],q[5]
h q[7]; //cycle: 118 //h q[4]
t q[10]; //cycle: 118 //t q[6]
cx q[10],q[5]; //cycle: 119 //cx q[6],q[7]
h q[7]; //cycle: 119 //h q[4]
h q[6]; //cycle: 120 //h q[2]
t q[1]; //cycle: 120 //t q[5]
t q[7]; //cycle: 120 //t q[4]
t q[6]; //cycle: 121 //t q[2]
cx q[6],q[10]; //cycle: 122 //cx q[2],q[6]
cx q[5],q[6]; //cycle: 124 //cx q[7],q[2]
tdg q[10]; //cycle: 124 //tdg q[6]
cx q[5],q[10]; //cycle: 126 //cx q[7],q[6]
t q[6]; //cycle: 126 //t q[2]
tdg q[5]; //cycle: 128 //tdg q[7]
tdg q[10]; //cycle: 128 //tdg q[6]
cx q[6],q[10]; //cycle: 129 //cx q[2],q[6]
cx q[5],q[6]; //cycle: 131 //cx q[7],q[2]
cx q[10],q[5]; //cycle: 133 //cx q[6],q[7]
h q[6]; //cycle: 133 //h q[2]
t q[6]; //cycle: 134 //t q[2]
cx q[6],q[1]; //cycle: 135 //cx q[2],q[5]
t q[5]; //cycle: 135 //t q[7]
t q[10]; //cycle: 135 //t q[6]
cx q[10],q[5]; //cycle: 136 //cx q[6],q[7]
cx q[7],q[6]; //cycle: 137 //cx q[4],q[2]
cx q[1],q[7]; //cycle: 139 //cx q[5],q[4]
tdg q[6]; //cycle: 139 //tdg q[2]
cx q[1],q[6]; //cycle: 141 //cx q[5],q[2]
t q[7]; //cycle: 141 //t q[4]
tdg q[1]; //cycle: 143 //tdg q[5]
tdg q[6]; //cycle: 143 //tdg q[2]
cx q[7],q[6]; //cycle: 144 //cx q[4],q[2]
cx q[1],q[7]; //cycle: 146 //cx q[5],q[4]
cx q[6],q[1]; //cycle: 148 //cx q[2],q[5]
h q[7]; //cycle: 148 //h q[4]
t q[7]; //cycle: 149 //t q[4]
t q[1]; //cycle: 150 //t q[5]
t q[6]; //cycle: 150 //t q[2]
cx q[6],q[1]; //cycle: 151 //cx q[2],q[5]
swap q[0],q[1]; //cycle: 153
cx q[7],q[1]; //cycle: 159 //cx q[4],q[3]
cx q[2],q[7]; //cycle: 161 //cx q[0],q[4]
cx q[1],q[2]; //cycle: 163 //cx q[3],q[0]
tdg q[7]; //cycle: 163 //tdg q[4]
cx q[1],q[7]; //cycle: 165 //cx q[3],q[4]
t q[2]; //cycle: 165 //t q[0]
tdg q[1]; //cycle: 167 //tdg q[3]
tdg q[7]; //cycle: 167 //tdg q[4]
cx q[2],q[7]; //cycle: 168 //cx q[0],q[4]
cx q[1],q[2]; //cycle: 170 //cx q[3],q[0]
cx q[7],q[1]; //cycle: 172 //cx q[4],q[3]
h q[2]; //cycle: 172 //h q[0]
h q[2]; //cycle: 173 //h q[0]
h q[7]; //cycle: 174 //h q[4]
t q[1]; //cycle: 174 //t q[3]
t q[2]; //cycle: 174 //t q[0]
t q[7]; //cycle: 175 //t q[4]
cx q[7],q[6]; //cycle: 176 //cx q[4],q[2]
swap q[0],q[1]; //cycle: 177
tdg q[6]; //cycle: 178 //tdg q[2]
cx q[1],q[7]; //cycle: 183 //cx q[5],q[4]
cx q[1],q[6]; //cycle: 185 //cx q[5],q[2]
t q[7]; //cycle: 185 //t q[4]
tdg q[1]; //cycle: 187 //tdg q[5]
tdg q[6]; //cycle: 187 //tdg q[2]
cx q[7],q[6]; //cycle: 188 //cx q[4],q[2]
cx q[1],q[7]; //cycle: 190 //cx q[5],q[4]
cx q[6],q[1]; //cycle: 192 //cx q[2],q[5]
h q[7]; //cycle: 192 //h q[4]
h q[7]; //cycle: 193 //h q[4]
h q[6]; //cycle: 194 //h q[2]
t q[1]; //cycle: 194 //t q[5]
t q[7]; //cycle: 194 //t q[4]
t q[6]; //cycle: 195 //t q[2]
cx q[6],q[10]; //cycle: 196 //cx q[2],q[6]
cx q[5],q[6]; //cycle: 198 //cx q[7],q[2]
tdg q[10]; //cycle: 198 //tdg q[6]
cx q[5],q[10]; //cycle: 200 //cx q[7],q[6]
t q[6]; //cycle: 200 //t q[2]
tdg q[5]; //cycle: 202 //tdg q[7]
tdg q[10]; //cycle: 202 //tdg q[6]
cx q[6],q[10]; //cycle: 203 //cx q[2],q[6]
cx q[5],q[6]; //cycle: 205 //cx q[7],q[2]
cx q[10],q[5]; //cycle: 207 //cx q[6],q[7]
h q[6]; //cycle: 207 //h q[2]
t q[6]; //cycle: 208 //t q[2]
cx q[6],q[1]; //cycle: 209 //cx q[2],q[5]
t q[10]; //cycle: 209 //t q[6]
t q[5]; //cycle: 209 //t q[7]
cx q[7],q[6]; //cycle: 211 //cx q[4],q[2]
cx q[1],q[7]; //cycle: 213 //cx q[5],q[4]
tdg q[6]; //cycle: 213 //tdg q[2]
cx q[1],q[6]; //cycle: 215 //cx q[5],q[2]
t q[7]; //cycle: 215 //t q[4]
tdg q[1]; //cycle: 217 //tdg q[5]
tdg q[6]; //cycle: 217 //tdg q[2]
cx q[7],q[6]; //cycle: 218 //cx q[4],q[2]
cx q[1],q[7]; //cycle: 220 //cx q[5],q[4]
cx q[6],q[1]; //cycle: 222 //cx q[2],q[5]
h q[7]; //cycle: 222 //h q[4]
t q[7]; //cycle: 223 //t q[4]
h q[6]; //cycle: 224 //h q[2]
t q[1]; //cycle: 224 //t q[5]
swap q[0],q[1]; //cycle: 225
t q[6]; //cycle: 225 //t q[2]
swap q[5],q[10]; //cycle: 226
cx q[1],q[7]; //cycle: 231 //cx q[3],q[4]
cx q[0],q[5]; //cycle: 232 //cx q[5],q[6]
cx q[2],q[1]; //cycle: 233 //cx q[0],q[3]
swap q[0],q[5]; //cycle: 234
cx q[7],q[2]; //cycle: 235 //cx q[4],q[0]
tdg q[1]; //cycle: 235 //tdg q[3]
cx q[7],q[1]; //cycle: 237 //cx q[4],q[3]
t q[2]; //cycle: 237 //t q[0]
tdg q[7]; //cycle: 239 //tdg q[4]
tdg q[1]; //cycle: 239 //tdg q[3]
cx q[6],q[5]; //cycle: 240 //cx q[2],q[5]
cx q[2],q[1]; //cycle: 240 //cx q[0],q[3]
swap q[1],q[6]; //cycle: 242
tdg q[5]; //cycle: 242 //tdg q[5]
cx q[7],q[2]; //cycle: 242 //cx q[4],q[0]
h q[2]; //cycle: 244 //h q[0]
h q[2]; //cycle: 245 //h q[0]
t q[2]; //cycle: 246 //t q[0]
cx q[0],q[1]; //cycle: 248 //cx q[6],q[2]
cx q[6],q[7]; //cycle: 248 //cx q[3],q[4]
cx q[0],q[5]; //cycle: 250 //cx q[6],q[5]
t q[1]; //cycle: 250 //t q[2]
h q[6]; //cycle: 250 //h q[3]
t q[7]; //cycle: 250 //t q[4]
t q[6]; //cycle: 251 //t q[3]
tdg q[0]; //cycle: 252 //tdg q[6]
tdg q[5]; //cycle: 252 //tdg q[5]
swap q[5],q[6]; //cycle: 253
cx q[1],q[6]; //cycle: 259 //cx q[2],q[5]
cx q[0],q[1]; //cycle: 261 //cx q[6],q[2]
swap q[0],q[5]; //cycle: 263
h q[1]; //cycle: 263 //h q[2]
t q[1]; //cycle: 264 //t q[2]
cx q[6],q[5]; //cycle: 269 //cx q[5],q[6]
t q[6]; //cycle: 271 //t q[5]
t q[5]; //cycle: 271 //t q[6]
cx q[1],q[6]; //cycle: 272 //cx q[2],q[5]
cx q[5],q[10]; //cycle: 272 //cx q[6],q[7]
cx q[0],q[1]; //cycle: 274 //cx q[3],q[2]
swap q[0],q[5]; //cycle: 276
tdg q[1]; //cycle: 276 //tdg q[2]
cx q[6],q[5]; //cycle: 282 //cx q[5],q[3]
cx q[6],q[1]; //cycle: 284 //cx q[5],q[2]
t q[5]; //cycle: 284 //t q[3]
swap q[0],q[5]; //cycle: 285
tdg q[6]; //cycle: 286 //tdg q[5]
tdg q[1]; //cycle: 286 //tdg q[2]
cx q[0],q[1]; //cycle: 291 //cx q[3],q[2]
swap q[1],q[6]; //cycle: 293
cx q[1],q[0]; //cycle: 299 //cx q[5],q[3]
cx q[6],q[1]; //cycle: 301 //cx q[2],q[5]
h q[0]; //cycle: 301 //h q[3]
h q[0]; //cycle: 302 //h q[3]
h q[6]; //cycle: 303 //h q[2]
t q[1]; //cycle: 303 //t q[5]
t q[0]; //cycle: 303 //t q[3]
t q[6]; //cycle: 304 //t q[2]
cx q[6],q[5]; //cycle: 305 //cx q[2],q[6]
cx q[10],q[6]; //cycle: 307 //cx q[7],q[2]
tdg q[5]; //cycle: 307 //tdg q[6]
cx q[10],q[5]; //cycle: 309 //cx q[7],q[6]
t q[6]; //cycle: 309 //t q[2]
tdg q[10]; //cycle: 311 //tdg q[7]
tdg q[5]; //cycle: 311 //tdg q[6]
cx q[6],q[5]; //cycle: 312 //cx q[2],q[6]
cx q[10],q[6]; //cycle: 314 //cx q[7],q[2]
cx q[5],q[10]; //cycle: 316 //cx q[6],q[7]
h q[6]; //cycle: 316 //h q[2]
t q[6]; //cycle: 317 //t q[2]
cx q[6],q[1]; //cycle: 318 //cx q[2],q[5]
t q[10]; //cycle: 318 //t q[7]
t q[5]; //cycle: 318 //t q[6]
cx q[5],q[10]; //cycle: 319 //cx q[6],q[7]
swap q[0],q[1]; //cycle: 320
cx q[1],q[6]; //cycle: 326 //cx q[3],q[2]
cx q[0],q[1]; //cycle: 328 //cx q[5],q[3]
tdg q[6]; //cycle: 328 //tdg q[2]
swap q[0],q[5]; //cycle: 330
t q[1]; //cycle: 330 //t q[3]
cx q[5],q[6]; //cycle: 336 //cx q[5],q[2]
tdg q[5]; //cycle: 338 //tdg q[5]
tdg q[6]; //cycle: 338 //tdg q[2]
cx q[1],q[6]; //cycle: 339 //cx q[3],q[2]
swap q[0],q[5]; //cycle: 340
cx q[0],q[1]; //cycle: 346 //cx q[5],q[3]
h q[1]; //cycle: 348 //h q[3]
t q[1]; //cycle: 349 //t q[3]
cx q[1],q[7]; //cycle: 350 //cx q[3],q[4]
swap q[0],q[5]; //cycle: 352
cx q[2],q[1]; //cycle: 352 //cx q[0],q[3]
cx q[7],q[2]; //cycle: 354 //cx q[4],q[0]
tdg q[1]; //cycle: 354 //tdg q[3]
cx q[7],q[1]; //cycle: 356 //cx q[4],q[3]
t q[2]; //cycle: 356 //t q[0]
cx q[6],q[5]; //cycle: 358 //cx q[2],q[5]
tdg q[7]; //cycle: 358 //tdg q[4]
tdg q[1]; //cycle: 358 //tdg q[3]
cx q[2],q[1]; //cycle: 359 //cx q[0],q[3]
t q[5]; //cycle: 360 //t q[5]
t q[6]; //cycle: 360 //t q[2]
cx q[7],q[2]; //cycle: 361 //cx q[4],q[0]
cx q[6],q[5]; //cycle: 361 //cx q[2],q[5]
cx q[1],q[7]; //cycle: 363 //cx q[3],q[4]
h q[2]; //cycle: 363 //h q[0]
h q[2]; //cycle: 364 //h q[0]
h q[1]; //cycle: 365 //h q[3]
t q[2]; //cycle: 365 //t q[0]
t q[1]; //cycle: 366 //t q[3]
cx q[1],q[6]; //cycle: 367 //cx q[3],q[2]
swap q[0],q[1]; //cycle: 369
tdg q[6]; //cycle: 369 //tdg q[2]
cx q[5],q[0]; //cycle: 375 //cx q[5],q[3]
cx q[5],q[6]; //cycle: 377 //cx q[5],q[2]
t q[0]; //cycle: 377 //t q[3]
tdg q[5]; //cycle: 379 //tdg q[5]
tdg q[6]; //cycle: 379 //tdg q[2]
swap q[0],q[5]; //cycle: 380
cx q[5],q[6]; //cycle: 386 //cx q[3],q[2]
cx q[0],q[5]; //cycle: 388 //cx q[5],q[3]
swap q[0],q[1]; //cycle: 390
h q[5]; //cycle: 390 //h q[3]
h q[5]; //cycle: 391 //h q[3]
t q[5]; //cycle: 392 //t q[3]
cx q[6],q[1]; //cycle: 396 //cx q[2],q[5]
swap q[0],q[5]; //cycle: 397
h q[6]; //cycle: 398 //h q[2]
t q[1]; //cycle: 398 //t q[5]
t q[6]; //cycle: 399 //t q[2]
cx q[6],q[5]; //cycle: 403 //cx q[2],q[6]
cx q[10],q[6]; //cycle: 405 //cx q[7],q[2]
tdg q[5]; //cycle: 405 //tdg q[6]
cx q[10],q[5]; //cycle: 407 //cx q[7],q[6]
t q[6]; //cycle: 407 //t q[2]
tdg q[10]; //cycle: 409 //tdg q[7]
tdg q[5]; //cycle: 409 //tdg q[6]
cx q[6],q[5]; //cycle: 410 //cx q[2],q[6]
cx q[10],q[6]; //cycle: 412 //cx q[7],q[2]
cx q[5],q[10]; //cycle: 414 //cx q[6],q[7]
h q[6]; //cycle: 414 //h q[2]
t q[6]; //cycle: 415 //t q[2]
cx q[6],q[1]; //cycle: 416 //cx q[2],q[5]
x q[5]; //cycle: 416 //x q[6]
x q[10]; //cycle: 416 //x q[7]
t q[5]; //cycle: 417 //t q[6]
swap q[0],q[1]; //cycle: 418
cx q[1],q[6]; //cycle: 424 //cx q[3],q[2]
cx q[0],q[1]; //cycle: 426 //cx q[5],q[3]
tdg q[6]; //cycle: 426 //tdg q[2]
swap q[0],q[5]; //cycle: 428
t q[1]; //cycle: 428 //t q[3]
cx q[5],q[6]; //cycle: 434 //cx q[5],q[2]
tdg q[5]; //cycle: 436 //tdg q[5]
tdg q[6]; //cycle: 436 //tdg q[2]
cx q[1],q[6]; //cycle: 437 //cx q[3],q[2]
swap q[0],q[5]; //cycle: 438
cx q[0],q[1]; //cycle: 444 //cx q[5],q[3]
swap q[6],q[11]; //cycle: 445
swap q[0],q[5]; //cycle: 446
h q[1]; //cycle: 446 //h q[3]
cx q[1],q[6]; //cycle: 451 //cx q[3],q[1]
cx q[11],q[5]; //cycle: 452 //cx q[2],q[5]
cx q[7],q[6]; //cycle: 453 //cx q[4],q[1]
x q[1]; //cycle: 453 //x q[3]
x q[5]; //cycle: 454 //x q[5]
t q[1]; //cycle: 454 //t q[3]
cx q[10],q[11]; //cycle: 454 //cx q[7],q[2]
t q[7]; //cycle: 455 //t q[4]
t q[5]; //cycle: 455 //t q[5]
cx q[1],q[7]; //cycle: 456 //cx q[3],q[4]
t q[10]; //cycle: 456 //t q[7]
t q[11]; //cycle: 456 //t q[2]
cx q[11],q[5]; //cycle: 457 //cx q[2],q[5]
cx q[2],q[1]; //cycle: 458 //cx q[0],q[3]
cx q[7],q[2]; //cycle: 460 //cx q[4],q[0]
tdg q[1]; //cycle: 460 //tdg q[3]
cx q[7],q[1]; //cycle: 462 //cx q[4],q[3]
t q[2]; //cycle: 462 //t q[0]
tdg q[7]; //cycle: 464 //tdg q[4]
tdg q[1]; //cycle: 464 //tdg q[3]
cx q[2],q[1]; //cycle: 465 //cx q[0],q[3]
cx q[7],q[2]; //cycle: 467 //cx q[4],q[0]
cx q[1],q[7]; //cycle: 469 //cx q[3],q[4]
h q[2]; //cycle: 469 //h q[0]
swap q[6],q[10]; //cycle: 470
h q[2]; //cycle: 470 //h q[0]
t q[7]; //cycle: 471 //t q[4]
t q[2]; //cycle: 471 //t q[0]
t q[1]; //cycle: 471 //t q[3]
cx q[7],q[6]; //cycle: 476 //cx q[4],q[7]
cx q[2],q[7]; //cycle: 478 //cx q[0],q[4]
cx q[6],q[2]; //cycle: 480 //cx q[7],q[0]
tdg q[7]; //cycle: 480 //tdg q[4]
cx q[6],q[7]; //cycle: 482 //cx q[7],q[4]
t q[2]; //cycle: 482 //t q[0]
tdg q[6]; //cycle: 484 //tdg q[7]
tdg q[7]; //cycle: 484 //tdg q[4]
cx q[2],q[7]; //cycle: 485 //cx q[0],q[4]
cx q[6],q[2]; //cycle: 487 //cx q[7],q[0]
cx q[7],q[6]; //cycle: 489 //cx q[4],q[7]
h q[2]; //cycle: 489 //h q[0]
h q[2]; //cycle: 490 //h q[0]
x q[7]; //cycle: 491 //x q[4]
t q[2]; //cycle: 491 //t q[0]
t q[6]; //cycle: 491 //t q[7]
t q[7]; //cycle: 492 //t q[4]
cx q[1],q[7]; //cycle: 493 //cx q[3],q[4]
cx q[2],q[1]; //cycle: 495 //cx q[0],q[3]
cx q[7],q[2]; //cycle: 497 //cx q[4],q[0]
tdg q[1]; //cycle: 497 //tdg q[3]
cx q[7],q[1]; //cycle: 499 //cx q[4],q[3]
t q[2]; //cycle: 499 //t q[0]
tdg q[7]; //cycle: 501 //tdg q[4]
tdg q[1]; //cycle: 501 //tdg q[3]
cx q[2],q[1]; //cycle: 502 //cx q[0],q[3]
cx q[7],q[2]; //cycle: 504 //cx q[4],q[0]
swap q[0],q[5]; //cycle: 505
cx q[1],q[7]; //cycle: 506 //cx q[3],q[4]
h q[2]; //cycle: 506 //h q[0]
swap q[6],q[11]; //cycle: 507
h q[2]; //cycle: 507 //h q[0]
h q[1]; //cycle: 508 //h q[3]
t q[7]; //cycle: 508 //t q[4]
t q[2]; //cycle: 508 //t q[0]
t q[1]; //cycle: 509 //t q[3]
cx q[1],q[6]; //cycle: 513 //cx q[3],q[2]
cx q[5],q[11]; //cycle: 513 //cx q[6],q[7]
cx q[0],q[1]; //cycle: 515 //cx q[5],q[3]
tdg q[6]; //cycle: 515 //tdg q[2]
swap q[0],q[5]; //cycle: 517
t q[1]; //cycle: 517 //t q[3]
cx q[5],q[6]; //cycle: 523 //cx q[5],q[2]
tdg q[5]; //cycle: 525 //tdg q[5]
tdg q[6]; //cycle: 525 //tdg q[2]
cx q[1],q[6]; //cycle: 526 //cx q[3],q[2]
swap q[5],q[6]; //cycle: 528
cx q[6],q[1]; //cycle: 534 //cx q[5],q[3]
cx q[5],q[6]; //cycle: 536 //cx q[2],q[5]
h q[1]; //cycle: 536 //h q[3]
h q[1]; //cycle: 537 //h q[3]
h q[5]; //cycle: 538 //h q[2]
t q[6]; //cycle: 538 //t q[5]
t q[1]; //cycle: 538 //t q[3]
t q[5]; //cycle: 539 //t q[2]
cx q[5],q[0]; //cycle: 540 //cx q[2],q[6]
cx q[11],q[5]; //cycle: 542 //cx q[7],q[2]
tdg q[0]; //cycle: 542 //tdg q[6]
t q[5]; //cycle: 544 //t q[2]
swap q[0],q[5]; //cycle: 545
cx q[11],q[5]; //cycle: 551 //cx q[7],q[6]
tdg q[11]; //cycle: 553 //tdg q[7]
tdg q[5]; //cycle: 553 //tdg q[6]
cx q[0],q[5]; //cycle: 554 //cx q[2],q[6]
swap q[5],q[11]; //cycle: 556
cx q[5],q[0]; //cycle: 562 //cx q[7],q[2]
swap q[1],q[6]; //cycle: 563
cx q[11],q[5]; //cycle: 564 //cx q[6],q[7]
h q[0]; //cycle: 564 //h q[2]
t q[0]; //cycle: 565 //t q[2]
t q[5]; //cycle: 566 //t q[7]
t q[11]; //cycle: 566 //t q[6]
cx q[11],q[5]; //cycle: 567 //cx q[6],q[7]
cx q[0],q[1]; //cycle: 569 //cx q[2],q[5]
swap q[0],q[5]; //cycle: 571
cx q[6],q[5]; //cycle: 577 //cx q[3],q[2]
cx q[1],q[6]; //cycle: 579 //cx q[5],q[3]
tdg q[5]; //cycle: 579 //tdg q[2]
swap q[0],q[1]; //cycle: 581
t q[6]; //cycle: 581 //t q[3]
cx q[0],q[5]; //cycle: 587 //cx q[5],q[2]
tdg q[0]; //cycle: 589 //tdg q[5]
tdg q[5]; //cycle: 589 //tdg q[2]
cx q[6],q[5]; //cycle: 590 //cx q[3],q[2]
swap q[0],q[1]; //cycle: 591
cx q[1],q[6]; //cycle: 597 //cx q[5],q[3]
h q[6]; //cycle: 599 //h q[3]
t q[6]; //cycle: 600 //t q[3]
cx q[6],q[7]; //cycle: 601 //cx q[3],q[4]
cx q[2],q[6]; //cycle: 603 //cx q[0],q[3]
swap q[0],q[5]; //cycle: 604
cx q[7],q[2]; //cycle: 605 //cx q[4],q[0]
tdg q[6]; //cycle: 605 //tdg q[3]
cx q[7],q[6]; //cycle: 607 //cx q[4],q[3]
t q[2]; //cycle: 607 //t q[0]
tdg q[7]; //cycle: 609 //tdg q[4]
tdg q[6]; //cycle: 609 //tdg q[3]
cx q[0],q[1]; //cycle: 610 //cx q[2],q[5]
cx q[2],q[6]; //cycle: 610 //cx q[0],q[3]
cx q[7],q[2]; //cycle: 612 //cx q[4],q[0]
t q[1]; //cycle: 612 //t q[5]
t q[0]; //cycle: 612 //t q[2]
cx q[0],q[1]; //cycle: 613 //cx q[2],q[5]
cx q[6],q[7]; //cycle: 614 //cx q[3],q[4]
h q[2]; //cycle: 614 //h q[0]
swap q[0],q[5]; //cycle: 615
h q[2]; //cycle: 615 //h q[0]
h q[6]; //cycle: 616 //h q[3]
t q[7]; //cycle: 616 //t q[4]
t q[2]; //cycle: 616 //t q[0]
t q[6]; //cycle: 617 //t q[3]
cx q[6],q[5]; //cycle: 621 //cx q[3],q[2]
cx q[1],q[6]; //cycle: 623 //cx q[5],q[3]
tdg q[5]; //cycle: 623 //tdg q[2]
swap q[0],q[1]; //cycle: 625
t q[6]; //cycle: 625 //t q[3]
cx q[0],q[5]; //cycle: 631 //cx q[5],q[2]
tdg q[0]; //cycle: 633 //tdg q[5]
tdg q[5]; //cycle: 633 //tdg q[2]
cx q[6],q[5]; //cycle: 634 //cx q[3],q[2]
swap q[1],q[6]; //cycle: 636
cx q[0],q[1]; //cycle: 642 //cx q[5],q[3]
cx q[5],q[0]; //cycle: 644 //cx q[2],q[5]
h q[1]; //cycle: 644 //h q[3]
h q[1]; //cycle: 645 //h q[3]
h q[5]; //cycle: 646 //h q[2]
t q[0]; //cycle: 646 //t q[5]
t q[1]; //cycle: 646 //t q[3]
t q[5]; //cycle: 647 //t q[2]
cx q[5],q[11]; //cycle: 648 //cx q[2],q[6]
cx q[6],q[5]; //cycle: 650 //cx q[7],q[2]
tdg q[11]; //cycle: 650 //tdg q[6]
cx q[6],q[11]; //cycle: 652 //cx q[7],q[6]
t q[5]; //cycle: 652 //t q[2]
tdg q[6]; //cycle: 654 //tdg q[7]
tdg q[11]; //cycle: 654 //tdg q[6]
cx q[5],q[11]; //cycle: 655 //cx q[2],q[6]
cx q[6],q[5]; //cycle: 657 //cx q[7],q[2]
cx q[11],q[6]; //cycle: 659 //cx q[6],q[7]
h q[5]; //cycle: 659 //h q[2]
t q[5]; //cycle: 660 //t q[2]
cx q[5],q[0]; //cycle: 661 //cx q[2],q[5]
t q[6]; //cycle: 661 //t q[7]
t q[11]; //cycle: 661 //t q[6]
cx q[11],q[6]; //cycle: 662 //cx q[6],q[7]
swap q[5],q[6]; //cycle: 664
cx q[1],q[6]; //cycle: 670 //cx q[3],q[2]
cx q[0],q[1]; //cycle: 672 //cx q[5],q[3]
tdg q[6]; //cycle: 672 //tdg q[2]
swap q[0],q[5]; //cycle: 674
t q[1]; //cycle: 674 //t q[3]
cx q[5],q[6]; //cycle: 680 //cx q[5],q[2]
tdg q[5]; //cycle: 682 //tdg q[5]
tdg q[6]; //cycle: 682 //tdg q[2]
cx q[1],q[6]; //cycle: 683 //cx q[3],q[2]
swap q[0],q[5]; //cycle: 684
cx q[0],q[1]; //cycle: 690 //cx q[5],q[3]
swap q[5],q[6]; //cycle: 691
h q[1]; //cycle: 692 //h q[3]
t q[1]; //cycle: 693 //t q[3]
cx q[7],q[1]; //cycle: 694 //cx q[4],q[3]
cx q[2],q[7]; //cycle: 696 //cx q[0],q[4]
cx q[5],q[0]; //cycle: 697 //cx q[2],q[5]
cx q[1],q[2]; //cycle: 698 //cx q[3],q[0]
tdg q[7]; //cycle: 698 //tdg q[4]
t q[0]; //cycle: 699 //t q[5]
t q[5]; //cycle: 699 //t q[2]
cx q[1],q[7]; //cycle: 700 //cx q[3],q[4]
t q[2]; //cycle: 700 //t q[0]
cx q[5],q[0]; //cycle: 700 //cx q[2],q[5]
tdg q[1]; //cycle: 702 //tdg q[3]
tdg q[7]; //cycle: 702 //tdg q[4]
cx q[2],q[7]; //cycle: 703 //cx q[0],q[4]
cx q[1],q[2]; //cycle: 705 //cx q[3],q[0]
cx q[7],q[1]; //cycle: 707 //cx q[4],q[3]
h q[2]; //cycle: 707 //h q[0]
swap q[5],q[6]; //cycle: 708
h q[2]; //cycle: 708 //h q[0]
h q[7]; //cycle: 709 //h q[4]
t q[1]; //cycle: 709 //t q[3]
t q[2]; //cycle: 709 //t q[0]
t q[7]; //cycle: 710 //t q[4]
cx q[7],q[6]; //cycle: 714 //cx q[4],q[2]
swap q[0],q[1]; //cycle: 715
tdg q[6]; //cycle: 716 //tdg q[2]
cx q[1],q[7]; //cycle: 721 //cx q[5],q[4]
cx q[1],q[6]; //cycle: 723 //cx q[5],q[2]
t q[7]; //cycle: 723 //t q[4]
tdg q[1]; //cycle: 725 //tdg q[5]
tdg q[6]; //cycle: 725 //tdg q[2]
cx q[7],q[6]; //cycle: 726 //cx q[4],q[2]
cx q[1],q[7]; //cycle: 728 //cx q[5],q[4]
cx q[6],q[1]; //cycle: 730 //cx q[2],q[5]
h q[7]; //cycle: 730 //h q[4]
h q[7]; //cycle: 731 //h q[4]
h q[6]; //cycle: 732 //h q[2]
t q[1]; //cycle: 732 //t q[5]
t q[7]; //cycle: 732 //t q[4]
t q[6]; //cycle: 733 //t q[2]
cx q[6],q[11]; //cycle: 734 //cx q[2],q[6]
cx q[5],q[6]; //cycle: 736 //cx q[7],q[2]
tdg q[11]; //cycle: 736 //tdg q[6]
cx q[5],q[11]; //cycle: 738 //cx q[7],q[6]
t q[6]; //cycle: 738 //t q[2]
tdg q[5]; //cycle: 740 //tdg q[7]
tdg q[11]; //cycle: 740 //tdg q[6]
cx q[6],q[11]; //cycle: 741 //cx q[2],q[6]
cx q[5],q[6]; //cycle: 743 //cx q[7],q[2]
cx q[11],q[5]; //cycle: 745 //cx q[6],q[7]
h q[6]; //cycle: 745 //h q[2]
t q[6]; //cycle: 746 //t q[2]
cx q[6],q[1]; //cycle: 747 //cx q[2],q[5]
t q[5]; //cycle: 747 //t q[7]
t q[11]; //cycle: 747 //t q[6]
cx q[11],q[5]; //cycle: 748 //cx q[6],q[7]
cx q[7],q[6]; //cycle: 749 //cx q[4],q[2]
cx q[1],q[7]; //cycle: 751 //cx q[5],q[4]
tdg q[6]; //cycle: 751 //tdg q[2]
cx q[1],q[6]; //cycle: 753 //cx q[5],q[2]
t q[7]; //cycle: 753 //t q[4]
tdg q[1]; //cycle: 755 //tdg q[5]
tdg q[6]; //cycle: 755 //tdg q[2]
cx q[7],q[6]; //cycle: 756 //cx q[4],q[2]
cx q[1],q[7]; //cycle: 758 //cx q[5],q[4]
cx q[6],q[1]; //cycle: 760 //cx q[2],q[5]
h q[7]; //cycle: 760 //h q[4]
t q[7]; //cycle: 761 //t q[4]
t q[1]; //cycle: 762 //t q[5]
t q[6]; //cycle: 762 //t q[2]
cx q[6],q[1]; //cycle: 763 //cx q[2],q[5]
swap q[0],q[1]; //cycle: 765
cx q[7],q[1]; //cycle: 771 //cx q[4],q[3]
cx q[2],q[7]; //cycle: 773 //cx q[0],q[4]
cx q[1],q[2]; //cycle: 775 //cx q[3],q[0]
tdg q[7]; //cycle: 775 //tdg q[4]
cx q[1],q[7]; //cycle: 777 //cx q[3],q[4]
t q[2]; //cycle: 777 //t q[0]
tdg q[1]; //cycle: 779 //tdg q[3]
tdg q[7]; //cycle: 779 //tdg q[4]
cx q[2],q[7]; //cycle: 780 //cx q[0],q[4]
cx q[1],q[2]; //cycle: 782 //cx q[3],q[0]
cx q[7],q[1]; //cycle: 784 //cx q[4],q[3]
h q[2]; //cycle: 784 //h q[0]
h q[7]; //cycle: 786 //h q[4]
t q[7]; //cycle: 787 //t q[4]
cx q[7],q[6]; //cycle: 788 //cx q[4],q[2]
swap q[0],q[1]; //cycle: 789
tdg q[6]; //cycle: 790 //tdg q[2]
cx q[1],q[7]; //cycle: 795 //cx q[5],q[4]
cx q[1],q[6]; //cycle: 797 //cx q[5],q[2]
t q[7]; //cycle: 797 //t q[4]
tdg q[1]; //cycle: 799 //tdg q[5]
tdg q[6]; //cycle: 799 //tdg q[2]
cx q[7],q[6]; //cycle: 800 //cx q[4],q[2]
cx q[1],q[7]; //cycle: 802 //cx q[5],q[4]
cx q[6],q[1]; //cycle: 804 //cx q[2],q[5]
h q[7]; //cycle: 804 //h q[4]
h q[7]; //cycle: 805 //h q[4]
h q[6]; //cycle: 806 //h q[2]
t q[1]; //cycle: 806 //t q[5]
t q[7]; //cycle: 806 //t q[4]
t q[6]; //cycle: 807 //t q[2]
cx q[6],q[11]; //cycle: 808 //cx q[2],q[6]
cx q[5],q[6]; //cycle: 810 //cx q[7],q[2]
tdg q[11]; //cycle: 810 //tdg q[6]
cx q[5],q[11]; //cycle: 812 //cx q[7],q[6]
t q[6]; //cycle: 812 //t q[2]
tdg q[5]; //cycle: 814 //tdg q[7]
tdg q[11]; //cycle: 814 //tdg q[6]
cx q[6],q[11]; //cycle: 815 //cx q[2],q[6]
cx q[5],q[6]; //cycle: 817 //cx q[7],q[2]
cx q[11],q[5]; //cycle: 819 //cx q[6],q[7]
h q[6]; //cycle: 819 //h q[2]
t q[6]; //cycle: 820 //t q[2]
cx q[6],q[1]; //cycle: 821 //cx q[2],q[5]
cx q[7],q[6]; //cycle: 823 //cx q[4],q[2]
cx q[1],q[7]; //cycle: 825 //cx q[5],q[4]
tdg q[6]; //cycle: 825 //tdg q[2]
cx q[1],q[6]; //cycle: 827 //cx q[5],q[2]
t q[7]; //cycle: 827 //t q[4]
tdg q[1]; //cycle: 829 //tdg q[5]
tdg q[6]; //cycle: 829 //tdg q[2]
cx q[7],q[6]; //cycle: 830 //cx q[4],q[2]
cx q[1],q[7]; //cycle: 832 //cx q[5],q[4]
cx q[6],q[1]; //cycle: 834 //cx q[2],q[5]
h q[7]; //cycle: 834 //h q[4]
//650 original gates
//706 gates in generated circuit
//571 ideal depth (cycles)
//836 depth of generated circuit
//653687 nodes popped from queue for processing.
//1091 nodes remain in queue.
