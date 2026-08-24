module ID_IE (
    input clock, reset, clear,
    input logic [31:0] read_data1,
    input logic [31:0] read_data2,
    input logic [31:0] inst,
    input logic [31:0] PCD,
    input logic [31:0] PCPlus4D,
    input logic [4:0] dest_regD,
    input logic [4:0] read_reg1, // changed
    input logic [4:0] read_reg2, // changed
    input logic [31:0] ImmExtD,
    input logic [2:0] ALUControlD,
    input logic [1:0] ResultSrcD,
    input logic RegWriteD,
    input logic MemWriteD,
    input logic BranchD,
    input logic jumpD,
    input logic ALUSrcD,
    output logic [31:0] read_data1E,
    output logic [31:0] read_data2E,
    output logic [2:0] ALUControlE,
    output logic [31:0] instrE,
    output logic [31:0] PCE,
    output logic [31:0] PCPlus4E,
    output logic [4:0] dest_regE,
    output logic [4:0] read_reg1E, // changed
    output logic [4:0] read_reg2E, // changed
    output logic [31:0] ImmExtE,
    output logic [1:0] ResultSrcE,
    output logic RegWriteE,
    output logic MemWriteE,
    output logic BranchE,
    output logic jumpE,
    output logic ALUSrcE
);

always_ff @(posedge clock or posedge reset) begin
    if(reset) begin
        read_data1E <= 0;
        read_data2E <= 0;
        instrE <= 0;
        PCE <= 0;
        PCPlus4E <= 0;
        dest_regE <= 0;
        read_reg1E <= 0; // changed
        read_reg2E <= 0; // changed
        ImmExtE <= 0;
        ALUControlE <= 0;
        ResultSrcE <= 0;
        RegWriteE <= 0;
        MemWriteE <= 0;
        BranchE <= 0;
        jumpE <= 0;
        ALUSrcE <= 0;
    end
    else if(clear) begin
        read_data1E <= 0;
        read_data2E <= 0;
        instrE <= 0;
        PCE <= 0;
        PCPlus4E <= 0;
        dest_regE <= 0;
        read_reg1E <= 0; // changed
        read_reg2E <= 0; // changed
        ImmExtE <= 0;
        ALUControlE <= 0;
        ResultSrcE <= 0;
        RegWriteE <= 0;
        MemWriteE <= 0;
        BranchE <= 0;
        jumpE <= 0;
        ALUSrcE <= 0;
    end
    else begin
        read_data1E <= read_data1;
        read_data2E <= read_data2;
        ALUControlE <= ALUControlD;
        instrE <= inst;
        PCE <= PCD;
        PCPlus4E <= PCPlus4D;
        dest_regE <= dest_regD;
        read_reg1E <= read_reg1;// changed
        read_reg2E <= read_reg2; // changed
        ImmExtE <= ImmExtD;
        RegWriteE <= RegWriteD;
        MemWriteE <= MemWriteD;
        BranchE <= BranchD;
        jumpE <= jumpD;
        ALUSrcE <= ALUSrcD;
        ResultSrcE <= ResultSrcD;
    end
end

endmodule