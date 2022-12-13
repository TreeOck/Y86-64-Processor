module add64bit(output signed [63:0]s, output of, input signed [63:0]a, input signed [63:0]b);

// Defining the carry wire and assigning the first input bit as 0 for addition operation
wire [64:0]carry;
assign carry[0] = 1'b0;

// Making the for loop for the 1-bit adder to go through every bit of the inputs
genvar i;
generate for(i=0;i<64;i=i+1)
begin
add1bit xJ(s[i], carry[i+1], a[i], b[i], carry[i]);
end
endgenerate

// Monitoring the overflow flag using the last two bits of the carry wire
xor xF1(of, carry[63], carry[64]);

endmodule