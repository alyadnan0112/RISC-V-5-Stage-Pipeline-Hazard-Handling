module Register_file (
    input logic clock, reset, RegWriteW,
    input logic [4:0] read_reg1, read_reg2, 
    input logic [4:0] dest_reg,
    input logic [31:0] write_back,
    output logic [31:0] read_data1, read_data2
);

logic [31:0] register [0:31];
integer index;

always_ff @( posedge clock or posedge reset ) begin
    if(reset) begin
        for(index = 0; index < 32; index = index + 1)
            register[index] <= 0;
    end
    else begin
        register[0] <= 0;
        if(RegWriteW && dest_reg != 0)
            register [dest_reg] <= write_back;
    end

end

always_comb begin
    read_data1 = register [read_reg1];
    read_data2 = register [read_reg2];
end

endmodule