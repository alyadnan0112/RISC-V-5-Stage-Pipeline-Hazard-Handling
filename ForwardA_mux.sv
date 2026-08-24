module ForwardA (
    input logic [1:0] ForwardAE,
    input logic [31:0] read_data1E,
    input logic [31:0] ResultW,
    input logic [31:0] ALUResultM,
    output logic [31:0] SrcAE
    
);

always_comb begin
    case (ForwardAE)
        2'b00 : SrcAE = read_data1E;
        2'b01 : SrcAE = ResultW;
        2'b10 : SrcAE = ALUResultM;
        default : SrcAE = 32'd0;;
    endcase
    
end
    
endmodule