module data_hazard (
    input logic [4:0] dest_regM,
    input logic [4:0] dest_regW,
    input logic RegWriteM,
    input logic RegWriteW,
    input logic PCSrcE,
    input logic [4:0] read_reg1E,
    input logic [4:0] read_reg2E,
    input logic [1:0] ResultSrcE,
    input logic [4:0] dest_regE,
    input logic [6:0] opcodeD,
    input logic [4:0] read_reg1D,
    input logic [4:0] read_reg2D,
    output logic [1:0] ForwardAE,
    output logic [1:0] ForwardBE,
    output logic stallF,
    output logic stallD,
    output logic flushD,
    output logic flushE
);

logic lwStall;
logic uses_rs1D;
logic uses_rs2D;

always_comb begin
   
    // Forwarding for ALU input A
    if ((read_reg1E == dest_regM) && RegWriteM && (read_reg1E != 5'b0))
        ForwardAE = 2'b10;
    else if ((read_reg1E == dest_regW) && RegWriteW && (read_reg1E != 5'b0))
        ForwardAE = 2'b01;
    else
        ForwardAE = 2'b00;
    
    // Forwarding for ALU input B
    if ((read_reg2E == dest_regM) && RegWriteM && (read_reg2E != 5'b0))
        ForwardBE = 2'b10;
    else if ((read_reg2E == dest_regW) && RegWriteW && (read_reg2E != 5'b0))
        ForwardBE = 2'b01;
    else
        ForwardBE = 2'b00;
    uses_rs1D = (opcodeD == 7'b0000011) ||
                (opcodeD == 7'b0100011) ||
                (opcodeD == 7'b0110011) ||
                (opcodeD == 7'b1100011) ||
                (opcodeD == 7'b0010011);
    uses_rs2D = (opcodeD == 7'b0100011) ||
                (opcodeD == 7'b0110011) ||
                (opcodeD == 7'b1100011);

    // Load-use hazard detection
    lwStall = ResultSrcE[0] && (dest_regE != 5'b0) &&
              ((uses_rs1D && (read_reg1D == dest_regE)) ||
               (uses_rs2D && (read_reg2D == dest_regE)));
    
    // Stall Fetch and Decode
    stallF = lwStall;
    stallD = lwStall;
   
    // Flush Decode for taken branch or jump
    flushD = PCSrcE;
    
    // Flush Execute for load-use hazard or taken branch/jump
    flushE = lwStall || PCSrcE;
end
endmodule