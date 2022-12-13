`timescale 1ns/1ps
`include "instructions.v"
module tester;

    output [63:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14;
    output [63:0] m1,m2,m3,m4,m5;

    //general use
    reg clk = 1;
    reg	imem_error = 0;
    reg dmem_error = 0;
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
    output [63:0]PC;
    wire [2024:0]IN;
    output instr_valid, need_regids, need_valC;
    output [63:0]valC;
    output [63:0]valP;

	//decode
	output [3:0]srcA;
    output [63:0]valA;
    output [3:0]srcB;
    output [63:0]valB;
    wire [1023:0] regfl; 

    //memory
    wire [(64*100):0] memblock;
    output read,write;
    output [63:0] address,data,valM;

	//writeback
    output [3:0]dstM;
    output [3:0]dstE;
    output test;
    
    processor .uut(.clk(clk),.instr_valid(instr_valid),.imem_error(imem_error),.dmem_error(dmem_error), .status(status),
	.aluA(aluA), .aluB(aluB), .alufun(alufun), .ZF(ZF), .SF(SF), .OF(OF), .setcc(setcc), .valE(valE),
	.icode(icode), .ifun(ifun), .rA(rA), .rB(rB), .valC(valC), .valP(valP), .need_regids(need_regids), .need_valC(need_valC), .PC(PC), .IN(IN), 
	.srcA(srcA), .valA(valA), .srcB(srcB), .valB(valB), .regg(regg), .memblock(memblock), .read(read), .write(write), .address(address), .data(data), .valM(valM),
    .dstE(dstE), .dstM(dstM), .test(test),
    .r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.r8(r8),.r9(r9),.r10(r10),.r11(r11),.r12(r12),.r13(r13),.r14(r14),
    .m1(m1), .m2(m2), .m3(m3), .m4(m4), .m5(m5));

    initial begin
        $dumpfile("tester.vcd");
     	$dumpvars(0,tester);

        #4400 $finish;
    end

    always #5 clk = ~clk;
endmodule
