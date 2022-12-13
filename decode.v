module decode(
    input [3:0]icode,
    input [3:0]rA,
    input [3:0]rB,
    input [1023:0]regg,
    output [64:0]valA,
    output [64:0]valB
);

/* Here, we have the decode stage of the sequential processor.
icode decides which instruction is being executed.
The values of rA and rB are used to determine the arguments provided to the instruction.

The decode computations are as follows:

1. cmov:
    valA <-- R[rA]
    valB <-- 0

2. irmovq:
    NONE

3. rmmovq:
    valA <-- R[rA]
    valB <-- R[rB]

4. mrmovq:
    valB <-- R[rB]

5. opq:
    valA <-- R[rA]
    valB <-- R[rB]

6. jXX:
    NONE

7. call:
    valB <--R[%rsp]

8. ret:
    valA <-- R[%rsp]
    valB <-- R[%rsp]
*/

always @(*) begin

// We start off by finding the src values separately using case statements on icode
    case (icode)
        `RET, `POPQ:
            srcA = `RSP;
        `RRMOVQ, `RMMOVQ, `OPQ, `PUSHQ:
            srcA = rA;
        default:
            srcA = 4'HF; 
    endcase

    case (icode)
        `RET, `POPQ:
            srcB = `RSP;
        `RRMOVQ, `RMMOVQ, `OPQ, `PUSHQ:
            srcB = rB;
        default:
            srcB = 4'HF;
    endcase
end

// Now, using the src values found above, we find the values of valA and valB to be used in further stages of the processor

assign valA = regg[(srcA * 64) +: 64];
assign valB = regg[(srcB * 64) +: 64];

endmodule
