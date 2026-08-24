module IE_MEM ( 
    input clock, reset, 
    input logic RegWriteE, 
    input logic MemWriteE, 
    input logic [1:0] ResultSrcE, 
    input logic [4:0] dest_regE, 
    input logic [31:0] PCPlus4E, 
    input logic [31:0] ALUResult, 
    input logic [31:0] read_data2E, 
 
    output logic RegWriteM, 
    output logic MemWriteM, 
    output logic [1:0] ResultSrcM, 
    output logic [4:0] dest_regM, 
    output logic [31:0] PCPlus4M, 
    output logic [31:0] ALUResultM, 
    output logic [31:0] read_data2M
);

always_ff @(posedge clock or posedge reset) begin
    if(reset) begin
        RegWriteM <= 0;
        MemWriteM <= 0;
        ResultSrcM <= 0;
        dest_regM <= 0;
        PCPlus4M <= 0;
        ALUResultM <= 0;
        read_data2M <= 0;
    end
    else begin
        RegWriteM <= RegWriteE;
        MemWriteM <= MemWriteE;
        ResultSrcM <= ResultSrcE;
        dest_regM <= dest_regE;
        PCPlus4M <= PCPlus4E;
        ALUResultM <= ALUResult;
        read_data2M <= read_data2E;
    end
end

endmodule