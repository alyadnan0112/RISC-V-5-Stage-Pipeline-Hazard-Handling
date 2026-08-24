module MEM_WB ( 
    input clock, reset,
    input logic RegWriteM,
    input logic [31:0] ALUResultM,
    input logic [4:0] dest_regM,
    input logic [31:0] read_data,
    input logic [31:0] PCPlus4M,
    input logic [1:0] ResultSrcM,

    output logic RegWriteW,
    output logic [31:0] ALUResultW,
    output logic [4:0] dest_regW,
    output logic [31:0] read_dataW,
    output logic [31:0] PCPlus4W,
    output logic [1:0] ResultSrcW
);

always_ff @(posedge clock or posedge reset) begin
    if(reset) begin
        RegWriteW <= 0;
        ALUResultW <= 0;
        dest_regW <= 0;
        read_dataW <= 0;
        PCPlus4W <= 0;
        ResultSrcW <= 0;
    end
    else begin
        RegWriteW <= RegWriteM;
        ALUResultW <= ALUResultM;
        dest_regW <= dest_regM;
        read_dataW <= read_data;
        PCPlus4W <= PCPlus4M;
        ResultSrcW <= ResultSrcM;
    end
end

endmodule