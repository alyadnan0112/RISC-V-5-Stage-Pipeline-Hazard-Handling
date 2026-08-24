module instruction_memory (
    input logic [31:0] PCF,
    output logic [31:0] instr
);
    logic [31:0] i_mem [0:127];

    initial begin
        $readmemh("imem.mem", i_mem);
    end

    always_comb begin
        instr = i_mem [PCF >> 2]; 
    end

endmodule