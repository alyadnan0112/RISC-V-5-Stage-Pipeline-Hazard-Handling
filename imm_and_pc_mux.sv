module imm_and_pc_mux (
    input logic [31:0] PCTargetE,
    input logic [31:0] PCPlus4F,
    input logic PCSrc,
    output logic [31:0] PCNext
);

always_comb begin
    case(PCSrc)
        0 : PCNext = PCPlus4F;
        1 : PCNext =  PCTargetE;
        default : PCNext = PCPlus4F;
    endcase

end
    
endmodule