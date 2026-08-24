module ALU_and_mem_mux (
    input logic [31:0] ALUResultW,
    input logic [31:0] read_dataW,
    input logic [31:0] PCPlus4W,
    input logic [1:0] ResultSrcW,
    output logic [31:0] ResultW
);

always_comb begin
    case(ResultSrcW)
        2'b00 : ResultW = ALUResultW;
        2'b01 : ResultW = read_dataW;
        2'b10 : ResultW = PCPlus4W;
        default : ResultW = 32'd0;
    endcase
end

endmodule