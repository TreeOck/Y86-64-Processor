module and64bit(output signed [63:0]c, input signed [63:0]b, input signed [63:0]a);

// Making the for loop to iterate through every bit of the inputs and find their AND
genvar i;
generate for(i=0; i<64; i=i+1) 
begin
and xA(c[i], a[i], b[i]);
end
endgenerate

endmodule