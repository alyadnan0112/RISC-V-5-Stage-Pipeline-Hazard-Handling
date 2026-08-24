module PC_calculation (
    input logic zeroE, BranchE, jumpE,
    input logic [31:0] PCF,
    input logic [31:0] PCE,
    input logic [31:0] immediate_extendedE,
    output logic [31:0] PCPlus4F,
    output logic [31:0] PCTargetE,
    output logic PCSrcE
);

always_comb begin

    PCPlus4F = PCF + 4;
    PCTargetE = PCE + immediate_extendedE;

    if((zeroE && BranchE) || jumpE)
        PCSrcE = 1;
    else
        PCSrcE = 0;

end

endmodule