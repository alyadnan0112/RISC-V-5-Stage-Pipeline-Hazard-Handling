module alu_control (
    input logic [1:0] ALUop,
    input logic [6:0] opcode,
    input logic [2:0] function3,
    input logic [6:0] function7,
    output logic [2:0] ALUControlD
);

always_comb begin
    ALUControlD = 3'b000;

    if(ALUop == 2'b00) begin
        ALUControlD = 3'b000; //lw,sw (add)
    end

    else if(ALUop == 2'b01) begin
        ALUControlD = 3'b001; //beq (sub)
    end

    else if(ALUop == 2'b10) begin

        if(function3 == 3'b000 && opcode == 7'b0110011 && function7 == 7'b0100000)
            ALUControlD = 3'b001; //sub

        else if(function3 == 3'b000)
            ALUControlD = 3'b000; //add / addi

        else if(function3 == 3'b001)
            ALUControlD = 3'b110; //sll / slli

        else if(function3 == 3'b010)
            ALUControlD = 3'b101; //slt / slti

        else if(function3 == 3'b100)
            ALUControlD = 3'b100; //xor / xori

        else if(function3 == 3'b101)
            ALUControlD = 3'b111; //srl / srli (sra not yet implemented in ALU)

        else if(function3 == 3'b110)
            ALUControlD = 3'b011; //or / ori

        else if(function3 == 3'b111)
            ALUControlD = 3'b010; //and / andi

    end
end

endmodule