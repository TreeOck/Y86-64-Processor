module fetch_reg(input clk, input [63:0]pc_predicted, output [63:0]pc_predicted_f);

/*
This is the pipeline register for the the execute block

At every next clock cycle, the input values that were stored are delivered as output
Non-blocking assignment is used here, since this transfer happens simultaneously for all variables
*/

always @(posedge clk ) begin
    pc_predicted_f <= pc_predicted;
end

endmodule