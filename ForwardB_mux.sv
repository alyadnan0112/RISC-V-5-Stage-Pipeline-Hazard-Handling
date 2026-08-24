module ForwardB (
    input logic [1:0] ForwardBE,
    input logic [31:0] read_data2E,
    input logic [31:0] ResultW,
    input logic [31:0] ALUResultM,
    output logic [31:0] SrcBE
    
);

always_comb begin
    case (ForwardBE)
        2'b00 : SrcBE = read_data2E;
        2'b01 : SrcBE = ResultW;
        2'b10 : SrcBE = ALUResultM;
        default : SrcBE = 32'd0;;
    endcase
    
end
    
endmodule