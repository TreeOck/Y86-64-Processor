module fetch(
  icode,ifun,rA,rB,valC,valP,instr_valid, need_regids, need_valC, PC, IN
);

input [63:0]PC;
input [2024:0]input_data;

output [3:0]icode;
output [3:0]ifun;
output [3:0]rA;
output [3:0]rB;
output instr_valid, need_regids, need_valC
output [63:0]valC;
output [63:0]valP;

// Here, we define the icode and ifun values using the variable PC. Since arrays in verilog do not allow us to use variables directly in the standard notation of arr[i:i+7], we use the following notation of arr[i+:8]
assign icode = input_data[(PC)+:4]; // icode is the first 4 bits of PC
assign ifun = input_data[(PC+4)+:4]; // ifun is the next 4 bits of PC

// We define conditions
assign instr_valid = (icode>12)?1:0; // When the instructions are valid
assign need_regids = ((icode>1&&icode<7)||icode==10||icode==11)?1:0; // When there is a register byte
assign need_valC = ((icode>2&&icode<9)&&icode!=6)?1:0; // When there is a constant word

assign rA = need_regids ? input_data[(PC+8)+:4]:4'HF;
assign rB = need_regids ? input_data[(PC+12)+:4]:4'HF;
assign valC = need_regids ? input_data[(PC+16)+:64]:input_data[(PC+8)+:64];
assign valP = PC + 8 + need_regids * 8 + need_valC * 64;

endmodule