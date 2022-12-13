module sub64bit(output signed [63:0]s, output of, input signed [63:0]a, input signed [63:0]b);

// Defining the carry wires for the carry and the negated input of B
wire [64:0]carry;
wire [63:0]bprime;

// Making the for loop for finding the complement of input B bitwise
genvar i;
generate for(i=0;i<64;i=i+1)
begin
not xN(bprime[i], b[i]);
end
endgenerate

// Calling the function made to subtract the two inputs
sub64bitassist xM(s, of, a, bprime);

endmodule