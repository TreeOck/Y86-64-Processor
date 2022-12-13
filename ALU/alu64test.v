module alu64test;

wire signed [63:0]ans;
wire of;

reg signed [63:0]a;
reg signed [63:0]b;
reg signed [1:0]op;

alu64bit uut(.ans(ans), .of(of), .a(a), .b(b), .op(op));

initial begin
    $dumpfile("alu64test.vcd");
    $dumpvars(0, alu64test);

    $monitor("\nOP  = %b\na   = %b\nb   = %b\nANS = %b\nOF  = %b", op, a, b, ans, of);

    op = 2'b00;
    a = 64'b0;
    b = 64'b0;

    #20 a = 64'd9223372036854775807; b = 64'd1; op = 2'b00;
    #20 a = -64'd9223372036854775808; b = 64'd1; op = 2'b01;
    #20 a = 64'd123; b = 64'd1; op = 2'b10;
    #20 a = -64'b0100; b = -64'b1111; op = 2'b11;
    #20 a = 64'd15; b = -64'd3; op = 2'b00;
end

endmodule