module writeback_reg(input clk, input cnd_m, input [3:0]icode_m, input [3:0]ifun_m, input [3:0]regA_m, input [3:0]regB_m, input [63:0]valA_m, input [63:0]valB_m, input [63:0]valP_m, input[63:0]valC_m, input [2:0]m_stat, input [63:0]valE_m, input [63:0]valM_m
output clk, output [3:0]icode_w, output cnd_w, output [3:0]ifun_w, output [3:0]regA_w, output [3:0]regB_w, output [63:0]valA_w, output [63:0]valB_w, output [63:0]valP_w, output[63:0]valC_w, output [2:0]w_stat, output [63:0]valE_w, output [63:0]valM_w);

always @(posedge clk ) begin
        icode_w <= icode_m;
        ifun_w <= ifun_m;
        regA_w <= regA_m;
        regB_w <= regB_m;
        valA_w <= valA_m;
        valP_w <= valP_m;
        valB_w <= valB_m;
        valC_w <= valC_m;
        w_stat <= m_stat;
        cnd_w <= cnd_m;
        valE_w <= valE_m;
        valM_w <= valM_m;
end

endmodule