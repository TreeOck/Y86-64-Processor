// Here we define the values for the different types of operations and registers in the processor

`define FETCH 2'b000
`define DECODE 2'b001
`define EXECUTE 2'b010
`define MEMORY 2'b011
`define WRITEBACK 2'b100

`define HALT 4'H0
`define NOP 4'H1
`define RRMOVQ 4'H2
`define IRMOVQ 4'H3
`define RMMOVQ 4'H4
`define MRMOVQ 4'H5
`define OPQ 4'H6
`define JXX 4'H7
`define CALL 4'H8
`define RET 4'H9
`define PUSHQ 4'HA
`define POPQ 4'HB

`define RAX 4'H0
`define RCX 4'H3
`define RDX 4'H1
`define RBX 4'H2
`define RSP 4'H4
`define RBP 4'H5
`define RSI 4'H6
`define RDI 4'H7
`define R8 4'H8
`define R9 4'H9
`define R10 4'HA
`define R11 4'HB
`define R12 4'HC
`define R13 4'HD
`define R14 4'HE

`define AOK 2'h0
`define HLT 2'h1
`define ADR 2'h2
`define INS 2'h3