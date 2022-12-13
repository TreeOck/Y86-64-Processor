module exec_reg(input clk, input [3:0]icode_d, input [3:0]ifun_d, input [3:0]regA_d, input [3:0]regB_d, input [63:0]valA_d, input [63:0]valB_d, input [63:0]valP_d, input[63:0]valC_d, input [2:0]d_stat,
output clk, output [3:0]icode_e, output [3:0]ifun_e, output [3:0]regA_e, output [3:0]regB_e, output [63:0]valA_e, output [63:0]valB_e, output [63:0]valP_e, output[63:0]valC_e, output [2:0]e_stat);

/*
This is the pipeline register for the the execute block

At every next clock cycle, the input values that were stored are delivered as output
Non-locking assignment is used here, since this transfer happens simultaneously for all variables
*/

always@(posedge clk)
    begin
        icode_e <= icode_d;
        ifun_e <= ifun_d;
        regA_e <= regA_d;
        regB_e <= regB_d;
        valA_e <= valA_d;
        valP_e <= valP_d;
        valB_e <= valB_d;
        valC_e <= valC_d;
        e_stat <= d_stat;
    end

endmodule