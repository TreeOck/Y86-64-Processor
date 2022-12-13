module memory(
    output reg [63:0]valM,
    output reg [63:0]data,
    input [3:0]icode,
    input [63:0]valA,
    input [63:0]valB,
    input [63:0]valE,
    input [63:0]valP
);

// this is memory data
reg [63:0] mem[0:255];

always@(*)begin
    // ret
    if(icode = 4'b1001) begin
        valM = mem[valE];
    end
    // call
    if(icode = 4'b1000) begin
        mem[valE] = valP;
    end
    // rmmovq
    if(icode = 4'b0100) begin
        mem[valE] = valA;
    end
    // mrmovq
    if(icode = 4'b0101) begin
        valM = mem[valE];
    end
    // pushq
    if(icode = 4'b1010) begin
        mem[valE] = valA;
    end
    // popq
    if(icode = 4'b1011) begin
        valM = mem[valE];
    end

    data = mem[valE];
end

endmodule