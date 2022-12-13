module writeback(input clk, input [3:0]icode, input [63:0]valE, input [63:0]valM, input [3:0]reg_A, input [3:0]reg_B);

initial begin

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

always @(*) begin

   assign mem_A = mem[((8*reg_A[3]) + (4*reg_A[2]) + (2*reg_A[1]) + reg_A[0])];  // Updating memory locations at every positive clock edge
   assign mem_B = mem[((8*reg_B[3]) + (4*reg_B[2]) + (2*reg_B[1]) + reg_B[0])];

    if(icode == 4'b0010)begin //cmov
        assign mem_B = valE;
    end

    else if (icode==4'b0011) begin //irmovq
        assign mem_B = valE;
    end

    else if (icode==4'b0100) begin //rmmovq
        
    end

    else if (icode==4'b0101) begin //mrmovq
        assign mem_A = valM;
    end

    else if (icode==4'b0110) begin //opq
        assign mem_B = valE;
    end

    else if (icode == 4'b0111) begin //jXX

    end

    else if (icode == 4'b1000) begin //call
        reg_sp = valE;
    end

    else if (icode == 4'b1001) begin //ret
        reg_sp = valE;
    end

    else if (icode == 4'b1010) begin //pushq
        reg_sp = valE;
    end

    else if (icode == 4'b1011) begin //popq
        reg_sp = valE;
        assign mem_A = valM;
    end
end

end

endmodule