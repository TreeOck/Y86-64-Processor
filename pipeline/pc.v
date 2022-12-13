module pc(
    output reg [63:0] pc,
    input [3:0]icode,
    input clk,
    input cnd,
    input [63:0]valC,
    input [63:0]valP,
    input [63:0]valM,
    input [63:0]pci
);

always @(*)
begin
    // for 'ret'
    if (icode == 4'b1001)
    begin
        pc = valM;
    end
    // for 'call'
    else if (icode == 4'b1000)
    begin
        pc = valC;
    end
    // for 'jmp'
    else if (icode == 4'b0111)
    // we need to check if the condition is true
    // if it is, we need to jump to the next instruction
    begin
        if (cnd)
        begin
            pc = valC;
        end
        else
        begin
            pc = valP;
        end
    end
end

endmodule