module data_memory (
    input logic clock, MemWriteM,
    input logic [31:0] ALUResultM,
    input logic [31:0] read_data2M,
    output logic [31:0] read_data
);

logic [31:0] mem [0:128];

always_ff @( posedge clock ) begin
    if(MemWriteM)
        mem[ALUResultM >> 2] <= read_data2M;

end

always_comb begin
    if(!MemWriteM)
        read_data = mem[ALUResultM >> 2];
    else
        read_data = 0;
end
    
endmodule