module decode(input clk, input [3:0]icode, input [3:0]reg_A, input [3:0]reg_B, input cnd , output [64:0]valA, output [64:0]valB);


initial begin

reg [64:0]mem_A; // Memory location associated with register rA
reg [64:0]mem_B; // Memory location associated with register rB

// Assigning register codes. We refer to them using an 15-element array of 64-bit registers.

reg[63:0] mem[14:0];

mem[14]=64'd14;
mem[13]=64'd13;
mem[12]=64'd12;
mem[11]=64'd11;
mem[10]=64'd10;
mem[9]=64'd9;
mem[8]=64'd8;
mem[7]=64'd7;
mem[6]=64'd6;
mem[5]=64'd5;
mem[4]=64'd4; // stack pointer
mem[3]=64'd3;
mem[2]=64'd2;
mem[1]=64'd1;
mem[0]=64'd0;

reg_sp = mem[4];

always @(posedge clk) begin
    
    mem_A = mem[((8*reg_A[3]) + (4*reg_A[2]) + (2*reg_A[1]) + reg_A[0])];  // Updating memory locations at every positive clock edge
    mem_B = mem[((8*reg_B[3]) + (4*reg_B[2]) + (2*reg_B[1]) + reg_B[0])];

    if(icode == 4'b0010)begin //cmov
        valA = mem_A;
        valB = 0;
    end

    else if (icode==4'b0011) begin //irmovq

    end

    else if (icode==4'b0100) begin //rmmovq
        valA = mem_A;
        valB = mem_B;
    end

    else if (icode==4'b0101) begin //mrmovq
    valB = mem_B;
    end

    else if (icode==4'b0110) begin //opq
        valA = mem_A;
        valB = mem_B;
    end

    else if (icode == 4'b0111) begin //jXX

    end

    else if (icode == 4'b1000) begin //call
        valB = reg_sp;
    end

    else if (icode == 4'b1001) begin //ret
        valA = reg_sp;
        valB = reg_sp;
    end

    else if (icode == 4'b1010) begin //pushq
        valA = mem_A;
        valB = reg_sp;
    end

    else if (icode == 4'b1011) begin //popq
        valA = mem_A;
        valB = mem_B;
    end
end

end

endmodule