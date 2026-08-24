module alu (
    input logic [31:0] SrcAE, SrcBE,
    input logic [2:0]  ALUControlE,
    output logic [31:0] ALUResultE,
    output logic zeroE
);
    always_comb begin
        ALUResultE = 32'b0;
        case (ALUControlE)
            3'b000: ALUResultE = SrcAE + SrcBE;
            3'b001: ALUResultE = SrcAE - SrcBE;
            3'b010: ALUResultE = SrcAE & SrcBE;
            3'b011: ALUResultE = SrcAE | SrcBE;
            3'b100: ALUResultE = SrcAE ^ SrcBE;
            3'b101: ALUResultE = ($signed(SrcAE) < $signed(SrcBE)) ? 32'd1 : 32'd0; // SLT
            3'b110: ALUResultE = SrcAE << SrcBE[4:0];            // SLL
            3'b111: ALUResultE = SrcAE >> SrcBE[4:0];            // SRL

            //3'b111: ALUResultE = $signed(SrcAE) >>> SrcBE[4:0];  // SRA
            //3'b1001: ALUResultE = (SrcAE < SrcBE) ? 32'd1 : 32'd0;                    // SLTU

            default: ALUResultE = 32'b0;
        endcase

        zeroE = (ALUResultE == 32'b0);
    end

endmodule