module decode_reg(input clk, input [3:0]icode_f, input [3:0]ifun_f, input [3:0]regA_f, input [3:0]regB_f, input [63:0]valC_f, input [63:0]valP_f, input [2:0]f_stat
output [3:0]icode_d, output [3:0]ifun_d, output [3:0]regA_d, output [3:0]regB_d, output [63:0]valC_d, output [63:0]valP_d, output [2:0]d_stat);

/*
This is the pipeline register for the the executdecode block

At every next clock cycle, the input values that were stored are delivered as output
Non-locking assignment is used here, since this transfer happens simultaneously for all variables
*/

always @(posedge clk ) begin
    icode_d <= icode_f;
    ifun_d <= ifun_f
    regA_d <= regA_f;
    regB_d <= regB_f;
    valC_d <= valC_f;
    valP_d <= valP_f;
end

endmodule

