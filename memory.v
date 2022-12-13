module memory(
    input clk,
    input [3:0]icode,
    input [63:0]valA,
    input [63:0]valE,
    input [63:0]valP,
    input instr_valid,
    input imem_error,
    input dmem_error,
    output reg [1:0]status,
    output reg read,
    output reg write,
    output reg [63:0]address,
    output reg [63:0]data,
    output reg [63:0]valM,
    output reg [(64*100):0]memblock
);

    initial memblock = 320'h00_00_00_00_00_00_00_01_00_00_00_00_00_00_00_03_00_00_00_00_00_00_00_05_00_00_00_00_00_00_00_04_00_00_00_00_00_00_00_02;
    initial status = `AOK;

    always @(*) begin
        case(icode)
            `MRMOVQ, `POPQ, `RET:
                read = 1;
            default:
                read = 0; 
        endcase

        case(icode)
            `RMMOVQ, `PUSHQ, `CALL:
                write = 1;
            default:
                write = 0; 
        endcase

        case(icode)
            `MRMOVQ, `RMMOVQ, `PUSHQ, `CALL:
                address = valE;
            `POPQ, `RET:
                address = valA;
            default:
                address = 0; 
        endcase

        case(icode)
            `RMMOVQ, `PUSHQ:
                data = valA;
            `CALL:
                data = valP;
            default:
                data = 0; 
        endcase

        if(imem_error || dmem_error)
            status = `ADR;
        else if(instr_valid)
            status = `INS;
        else if(icode == `HALT)
            status = `HLT;
        else
            status = `AOK;

    if(read)
        valM = memblock[(address*64) +: 64];
    end

    always @(negedge clk) begin
        if(write)
            memblock[(address*64) +: 64] = data;
    end
endmodule