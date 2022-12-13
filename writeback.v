module writeback(
    input clk,
    input [3:0]icode,
    input [3:0]ifun,
    input [3:0]rA,
    input [3:0]rB,
    input [63:0]valE,
    input [63:0]valM,
    output reg [3:0]dstM,
    output reg [3:0]dstE,
    output ZF,
    output SF,
    output OF
);

/* The writeback computations are as follows:

1. cmov:
    R[rB] <-- valE

2. irmovq:
    R[rB] <-- valE

3. rmmovq:
    NONE

4. mrmovq:
    R[rA] <-- valM

5. opq:
    R[rB] <-- valE

6. jXX:
    NONE

7. call:
    R[%rsp] <-- valE

8. ret:
    R[%rsp] <-- valE

9. pushq:
    R[%rsp] <-- valE

10 popq:
    R[%rsp] <-- valE
    R[rA] <-- valM
*/

always @(*) begin
    case (icode)
        `MRMOVQ:
        begin
            dstM = rA;
            dstE = 4'HF;
        end
        `POPQ:
        begin
            dstM = rA; 
            dstE = `RSP;
        end
        `IRMOVQ, `OPQ:
        begin
            dstE = rB; 
            dstM = 4'HF;
        end
        `RRMOVQ:
        begin
            if((ifun == 0 || (ifun == 1 && (ZF == 1 || SF==1)) || (ifun == 2 && SF == 1) || (ifun == 3 && ZF == 1) || (ifun == 4 && ZF == 0) || (ifun == 5 && (SF == 0 || ZF == 1)) || (ifun == 6 && SF == 0)))
            begin
                dstE = rB; 
                dstM = 4'HF;
            end
            else begin
                dstE = 4'HF; 
                dstM = 4'HF;
            end
        end
        `PUSHQ, `CALL, `RET:
        begin
            dstE = `RSP; 
            dstM = 4'HF;
        end

        default:
        begin
            dstE = 4'HF; 
            dstM = 4'HF; 
        end
    endcase
end

// Now we proceed to writeback the values to the register regg at the negative edge of the clock

always @(negedge clk) begin
    regg[(dstE * 64)+:64] = (dstE == 4'HF)?regg[(dstE * 64)+:64] : valE;
    regg[(dstM * 64)+:64] = (dstM == 4'HF)?regg[(dstM * 64)+:64] : valM;
end


endmodule
