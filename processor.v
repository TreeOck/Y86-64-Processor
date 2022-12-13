`include "instructions.v"
`include "fetch.v"
`include "decode.v"
`include "execute.v"
`include "memory.v"
`include "writeback.v"

module processor(
	clk,instr_valid,imem_error,dmem_error, status,
	aluA,aluB,alufun,ZF,SF,OF,setcc,valE,
	icode,ifun,rA,rB,valC,valP, need_regids, need_valC, PC,IN, 
	srcA,valA,srcB,valB,regg,
	read, write, address, data, valM, memblock,
	dstE, dstM,test,
	r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,
	m1,m2,m3,m4,m5
);

//general use
input clk;
input imem_error;
input dmem_error;
output test;
output [1:0] status;

//ALU or execute
output [63:0] aluA;
output [63:0] aluB;
output [3:0] alufun;
output setcc;
output [63:0] valE;
output ZF;
output SF;
output OF;

//fetch
output [3:0]icode,ifun,rA,rB;
output reg [63:0]PC;
output reg [2024:0]IN;

output [63:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14;
output [63:0] m1,m2,m3,m4,m5;


initial IN = 2024'h00_00_00_00_00_00_00_00_f0_07_00_00_00_00_00_00_04_40_37_27_16_00_00_00_00_00_00_01_40_47_82_16_81_02_17_06_00_00_00_00_00_00_00_01_13_04_00_00_00_00_00_00_00_00_14_04_00_00_00_00_00_00_03_28_57_00_00_00_00_00_00_00_00_13_05_34_16_00_00_00_00_00_00_00_01_14_05_00_00_00_00_00_00_00_00_13_05_00_00_00_00_00_00_00_00_1f_03_00_00_00_00_00_00_00_01_7f_03_00_00_00_00_00_00_00_04_2f_03_00_00_00_00_00_00_00_00_1f_03;

output instr_valid, need_regids, need_valC;
output [63:0]valC;
output [63:0]valP;

//decode
output [3:0]srcA;
output [63:0]valA;
output [3:0]srcB;
output [63:0]valB;
output [1023:0] regg;

assign r0 = regg[(0 * 64) +: 64];
assign r1 = regg[(1 * 64) +: 64];
assign r2 = regg[(2 * 64) +: 64];
assign r3 = regg[(3 * 64) +: 64];
assign r4 = regg[(4 * 64) +: 64];
assign r5 = regg[(5 * 64) +: 64];
assign r6 = regg[(6 * 64) +: 64];
assign r7 = regg[(7 * 64) +: 64];
assign r8 = regg[(8 * 64) +: 64];
assign r9 = regg[(9 * 64) +: 64];
assign r10 = regg[(10 * 64) +: 64];
assign r11 = regg[(11 * 64) +: 64];
assign r12 = regg[(12 * 64) +: 64];
assign r13 = regg[(13 * 64) +: 64];
assign r14 = regg[(14 * 64) +: 64];


assign m1 = memblock[(0 * 64) +: 64];
assign m2 = memblock[(1 * 64) +: 64];
assign m3 = memblock[(2 * 64) +: 64];
assign m4 = memblock[(3 * 64) +: 64];
assign m5 = memblock[(4 * 64) +: 64];

//memory
output [(64*100):0] memblock;
output read,write;
output [63:0] address,data,valM;

//writeback
output [3:0]dstM;
output [3:0]dstE;

initial begin
	PC <= 0;
end

//control inputs
// Linking the blocks

fetch fblock (icode,ifun,rA,rB,valC,valP, instr_valid,need_regids, need_valC, PC, IN);
decode dblock (icode,rA,rB,srcA,valA,srcB,valB,regg);
execute eblock (icode, ifun, ZF, SF, OF,valA,valB,valC, setcc, aluA, aluB, alufun, valE,clk);
memory mblock (icode, valA, valE, valP,instr_valid, imem_error,dmem_error, status, read, write, address, data, valM, memblock,clk);
writeback wblock (icode,ifun,ZF,SF,OF,rA,rB,dstM,valM,dstE,valE,regg,clk);

// Status checking
always @(posedge clk) 
begin
	case (icode)
		`CALL: 
			if(status == `AOK) PC = valC;
		`JXX :
			if((status == `AOK) && (ifun == 0 || (ifun == 1 && (ZF == 1 || SF==1)) || (ifun == 2 && SF == 1) || (ifun == 3 && ZF == 1) || (ifun == 4 && ZF == 0) || (ifun == 5 && (SF == 0 || ZF == 1)) || (ifun == 6 && SF == 0)))	PC = valC;
			else PC = valP;
		`RET :
			if(status == `AOK) PC = valM;
		default: 
			if(status == `AOK) PC = valP;
	endcase

end

endmodule