`include "ALU.v"
module execute(icode, ifun, ZF, SF, OF,valA,valB,valC, setcc, aluA, aluB, alufun, valE,clk);
    input clk;
    input [3:0] icode;
    input [3:0] ifun;
    input [63:0] valA,valB,valC;
    
    output reg ZF,SF,OF;
    output reg setcc;
    output reg [63:0] aluA;
    output reg [63:0] aluB;
    output reg [3:0] alufun;
    output [63:0] valE;

    
    always@(posedge clk,icode) begin
        alufun = (icode == `OPQ) ? ifun : 0;
        setcc = (icode == `OPQ);
    end


    always @(*) begin
        
        case(icode)
            `IRMOVQ, `RMMOVQ, `MRMOVQ:
                aluA = valC;
            `RRMOVQ,`OPQ:
                aluA = valA;
            `CALL,`PUSHQ:
                aluA = -1;
            `POPQ, `RET:
                aluA = 1;
            default:
                aluA = 4'HF; 
        endcase

        case(icode)
            `RMMOVQ, `MRMOVQ, `OPQ, `CALL,`PUSHQ,`POPQ, `RET:
                aluB = valB;
            `RRMOVQ, `IRMOVQ:
                aluB = 0;
            default:
                aluB = 4'HF; 
        endcase

    end

    ALU exec (aluA,aluB,alufun[0 +: 2],valE,clk);

    always@(*) begin
        
        if (setcc && clk==1) begin
            ZF = (valE == 0)? 1 : 0;
            SF = (valE[63] == 0)? 0 : 1;

        if(alufun == 2'b00)
            OF = (aluA[63]==aluB[63]) & (aluA[63]!=valE[63]);
        else if(alufun == 2'b01)
            OF = (aluA[63]!=aluB[63]) & (aluA[63]!=valE[63]);
        else
            OF = 0;
    end
    end

    always @(negedge clk)
        setcc = 0;
endmodule