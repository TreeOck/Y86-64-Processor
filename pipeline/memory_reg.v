module memory_reg(
    output reg [2:0]mstat,
    output reg[3:0]micode,
    output reg [3:0]mrA,
    output reg [3:0]mrB,
    output reg [63:0]mvalC,
    output reg [63:0]mvalP,
    output reg [63:0]mvalA,
    output reg [63:0]mvalB,
    output reg [63:0]mvalE,
    input [2:0]estat,
    input [3:0]eicode,
    input [3:0]erA,
    input [3:0]erB,
    output reg mcnd,
    input [63:0]evalC,
    input [63:0]evalP,
    input [63:0]evalA,
    input [63:0]evalB,
    input [63:0]evalE,
    input ecnd
);

always @(posedge clk ) begin
    mstat <= estat;
    micode <= eicode;
    mrA <= erA;
    mrB <= erB;
    mvalC <= evalC;
    mvalP <= evalP;
    mvalA <= evalA;
    mvalB <= evalB;
    mvalE <= evalE;
    mcnd <= ecnd;
end

endmodule