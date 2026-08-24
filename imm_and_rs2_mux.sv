module imm_and_rs2_mux (
    input logic [31:0] immediate_extendedE,
    input logic [31:0] read_data2E,
    input logic ALUSrcE,
    output logic [31:0] SrcBE
);

always_comb begin
    case(ALUSrcE)
        0 : SrcBE = read_data2E;
        1 : SrcBE =  immediate_extendedE;
        default : SrcBE = read_data2E;
    endcase
end
    
endmodule

