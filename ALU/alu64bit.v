`include "add64bit.v"
`include "add1bit.v"

`include "sub64bit.v"
`include "sub64bitassist.v"

`include "and64bit.v"
`include "xor64bit.v"

module alu64bit(output signed [63:0]ans, output of, input signed [63:0]a, input signed [63:0]b, input signed [1:0]op);

// Declaring signed registers for assigning temporary answer and overflow flag
reg signed [63:0]teans;
reg signed [63:0]teof;

// Declaring signed wires for outputs of the different modules, and for the overflow output of the ADD and SUB module
wire signed [63:0]added;
wire signed [63:0]subed;
wire signed [63:0]anded;
wire signed [63:0]xored;
wire ofa;
wire ofs;

// Calling the different modules and getting their outputs
add64bit xA(added, ofa, a, b);
sub64bit xS(subed, ofs, a, b);
and64bit xAA(anded, a, b);
xor64bit xX(xored, a, b);

// Making the always block (* is used for logic gates, or for letting the program build the sensitivity list on it's own)
// and assigning the different control inputs via op to the different modules so as to redirect the output to the teans and teof
always@(*)
begin
    case(op)
        2'b00:begin
            teans = added;
            teof = ofa;
        end
        2'b01:begin
            teans = subed;
            teof = ofs;
        end
        2'b10:begin
            teans = anded;
            teof = 1'b0;
        end
        2'b11:begin
            teans = xored;
            teof = 1'b0;
        end
    endcase
end

// Assigning the final output of the ALU as the temporary answer and the overflow flag
assign ans = teans;
assign of = teof;

endmodule