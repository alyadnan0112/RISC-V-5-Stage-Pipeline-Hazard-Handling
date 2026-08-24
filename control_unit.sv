module control_unit (
    input logic reset,
    input logic [6:0] opcode,
    output logic MemWriteD, ALUSrcD, RegWriteD, BranchD, jumpD,
    output logic [1:0] ALUop, ResultSrcD,
    output logic [1:0] ImmSrcD
);

always_comb begin
    RegWriteD  = 0;
    ImmSrcD    = 2'b00;
    ALUSrcD    = 0;
    MemWriteD  = 0;
    ResultSrcD = 2'b00;
    BranchD    = 0;
    jumpD      = 0;
    ALUop      = 2'b00;

    if(!reset) begin
        if(opcode == 7'b0000011) begin //lw
            RegWriteD  = 1;
            ImmSrcD    = 2'b00;
            ALUSrcD    = 1;
            MemWriteD  = 0;
            ResultSrcD = 2'b01;
            BranchD    = 0;
            jumpD      = 0;
            ALUop     = 2'b00;
        end 
    
        else if(opcode == 7'b0100011) begin //sw
            RegWriteD = 0;
            ImmSrcD   = 2'b01;
            ALUSrcD   = 1;
            MemWriteD = 1;
            BranchD   = 0;
            jumpD     = 0;
            ALUop    = 2'b00;
        end
    
        else if(opcode == 7'b0110011) begin //r-type
            RegWriteD  = 1;
            ImmSrcD    = 2'b00; 
            ALUSrcD    = 0;     
            MemWriteD  = 0;
            ResultSrcD = 2'b00; 
            BranchD    = 0;
            jumpD      = 0;
            ALUop     = 2'b10;
        end
    
        else if(opcode == 7'b1100011) begin //beq
            RegWriteD = 0;
            ImmSrcD   = 2'b10;
            ALUSrcD   = 0;
            MemWriteD = 0;
            BranchD   = 1;
            jumpD     = 0;
            ALUop    = 2'b01;
        end
    
        else if(opcode == 7'b0010011) begin //addi
            RegWriteD  = 1;
            ImmSrcD    = 2'b00;
            ALUSrcD    = 1;
            MemWriteD  = 0;
            ResultSrcD = 2'b00;
            BranchD    = 0;
            jumpD      = 0;
            ALUop     = 2'b10;
        end
    
        else if(opcode == 7'b1101111) begin //jal
            RegWriteD  = 1;
            ImmSrcD    = 2'b11;
            MemWriteD  = 0;
            ResultSrcD = 2'b10;
            BranchD    = 0;
            jumpD      = 1;
            ALUop     = 2'b00; // don't-care, but explicit avoids latch risk
        end
    end
end
    
endmodule