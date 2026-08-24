module immediate_extension (
    input logic [31:0] instrD,
    input logic [1:0] ImmSrcD,
    output logic [31:0] immediate_extendedD
);

always_comb begin
    case(ImmSrcD)
        2'b00 : immediate_extendedD = {{20{instrD[31]}}, instrD[31:20]}; //i-type lw
        2'b01 : immediate_extendedD = {{20{instrD[31]}}, instrD[31:25], instrD[11:7]}; //s-type store
        2'b10 : immediate_extendedD = {{20{instrD[31]}}, instrD[7], instrD[30:25], instrD[11:8], 1'b0}; //B-type
        2'b11 : immediate_extendedD = {{12{instrD[31]}}, instrD[19:12], instrD[20], instrD[30:21], 1'b0}; //j-type
        default : immediate_extendedD = 32'b0;
    endcase
end

endmodule