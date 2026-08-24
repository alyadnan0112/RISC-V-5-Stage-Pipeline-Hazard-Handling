module IF_ID (
    input clock, reset, enable, clear, 
    input logic [31:0] instr,
    input logic [31:0] PCPlus4,
    input logic [31:0] PC,
    output logic [31:0] instrD,
    output logic [31:0] PCD,
    output logic [31:0] PCPlus4D
);

always_ff @(posedge clock or posedge reset) begin
    if(reset || clear) begin
        instrD <= 0;
        PCD <= 0;
        PCPlus4D <= 0;
    end
    else if(!enable) begin
        instrD <= instrD;
        PCD <= PCD;
        PCPlus4D <= PCPlus4D;
    end
    else begin
        instrD <= instr;
        PCD <= PC;
        PCPlus4D <= PCPlus4;
    end
end

endmodule