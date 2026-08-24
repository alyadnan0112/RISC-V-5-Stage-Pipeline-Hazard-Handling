module top (
    input logic clock, reset
);

logic [31:0] instr;

// for satll
logic stallD;
logic stallF;
logic enable;
logic clear;
logic flushD;
logic flushE;

//pc values
logic [31:0] PCNext;
logic [31:0] PCF;
logic [31:0] PCTargetE;
logic [31:0] PCPlus4F;

//program counter ports
logic [4:0] read_reg1;
logic [4:0] read_reg2;
logic [4:0] dest_reg;

//alu input port
logic [31:0] read_data1;
logic [31:0] SrcAE;

//immediate and rs2 mux port
logic [31:0] read_data2;
logic [31:0] read_data2ForwardedE;
logic [31:0] SrcBE;

//immediate extension ports
logic [31:0] immediate_extendedD;

//control ports
logic BranchD;
logic jumpD;
logic zeroE;
logic BranchE;
logic jumpE;
logic PCSrcE;
logic ALUSrcD;
logic [1:0] ALUop;
logic [1:0] ImmSrcD;

//alu control ports
logic [6:0] opcode;
logic [2:0] function3;
logic [6:0] function7;
logic [2:0] ALUControlD;
logic [2:0] ALUControlE;

//data memory ports
logic [31:0] read_data;
logic [31:0] ALUResultE;
logic [31:0] ResultW;


// data_hazard ports
logic [1:0] ForwardAE;
logic [1:0] ForwardBE;

// IF/ID outputs
logic [31:0] instrD;
logic [31:0] PCD;
logic [31:0] PCPlus4D;

//ID/EX signals
logic [1:0] ResultSrcD;
logic RegWriteD;
logic MemWriteD;

logic [31:0] read_data1E;
logic [31:0] read_data2E;
logic [31:0] instrE;
logic [31:0] PCE;
logic [31:0] PCPlus4E;
logic [4:0] dest_regE;
logic [31:0] ImmExtE;
logic [1:0] ResultSrcE;
logic RegWriteE;
logic MemWriteE;
logic ALUSrcE;
logic [4:0] read_reg1E; // changed
logic [4:0] read_reg2E; // changed

//EX/MEM signals
logic [31:0] ALUResultM;
logic [31:0] read_data2M;
logic [31:0] PCPlus4M;
logic [4:0] dest_regM;
logic RegWriteM;
logic MemWriteM;
logic [1:0] ResultSrcM;

//MEM/WB signals
logic [31:0] ALUResultW;
logic [31:0] read_dataW;
logic [31:0] PCPlus4W;
logic [4:0] dest_regW;
logic RegWriteW;
logic [1:0] ResultSrcW;

assign opcode = instrD[6:0];
assign dest_reg = instrD[11:7];
assign function3 = instrD[14:12];
assign read_reg1 = instrD[19:15];
assign read_reg2 = instrD[24:20];
assign function7 = instrD[31:25];

//DONE
program_counter pc(
                    .clock(clock),
                    .reset(reset),
                    .enable(!stallF), // for stall
                    .PCNext(PCNext),
                    .PCF(PCF)
                    );

//DONE
PC_calculation PC_cal(
                    .zeroE(zeroE),
                    .BranchE(BranchE),
                    .jumpE(jumpE),
                    .PCE(PCE),
                    .PCF(PCF),
                    .immediate_extendedE(ImmExtE),
                    .PCPlus4F(PCPlus4F),
                    .PCTargetE(PCTargetE),
                    .PCSrcE(PCSrcE)
                    );

//done
imm_and_pc_mux mux1(
                    .PCTargetE(PCTargetE),
                    .PCPlus4F(PCPlus4F),
                    .PCSrc(PCSrcE),
                    .PCNext(PCNext)
                    );

//DONE
instruction_memory instr_mem(
                            .PCF(PCF),
                            .instr(instr)
                            );

//done
immediate_extension imm(
                        .instrD(instrD),
                        .ImmSrcD(ImmSrcD),
                        .immediate_extendedD(immediate_extendedD)
                        );

//done
Register_file reg_file(
                        .clock(clock),
                        .reset(reset),
                        .RegWriteW(RegWriteW),
                        .read_reg1(read_reg1),
                        .read_reg2(read_reg2),
                        .dest_reg(dest_regW),
                        .write_back(ResultW),
                        .read_data1(read_data1),
                        .read_data2(read_data2)
                        );

//DONE
imm_and_rs2_mux mux2(
                    .immediate_extendedE(ImmExtE),
                    .read_data2E(read_data2ForwardedE),
                    .ALUSrcE(ALUSrcE),
                    .SrcBE(SrcBE)
                    );

//DONE
control_unit contr1(
                    .reset(reset),
                    .opcode(opcode),
                    .ResultSrcD(ResultSrcD),
                    .MemWriteD(MemWriteD),
                    .ALUSrcD(ALUSrcD),
                    .RegWriteD(RegWriteD),
                    .BranchD(BranchD),
                    .jumpD(jumpD),
                    .ALUop(ALUop),
                    .ImmSrcD(ImmSrcD)
                    );

//DONE
alu_control contr2(
                  .ALUop(ALUop),
                  .opcode(opcode),
                  .function3(function3),
                  .function7(function7),
                  .ALUControlD(ALUControlD)
                  );

//DONE
alu alu1(
        .SrcAE(SrcAE),
        .SrcBE(SrcBE),
        .ALUControlE(ALUControlE),
        .ALUResultE(ALUResultE),
        .zeroE(zeroE)
        );

//DONE
data_memory data_mem(
                    .clock(clock),
                    .MemWriteM(MemWriteM),
                    .read_data2M(read_data2M),
                    .ALUResultM(ALUResultM),
                    .read_data(read_data)
                    );

//DONE
ALU_and_mem_mux mux3(
                    .ALUResultW(ALUResultW),
                    .read_dataW(read_dataW),
                    .PCPlus4W(PCPlus4W),
                    .ResultSrcW(ResultSrcW),
                    .ResultW(ResultW)
                    );

IF_ID R1( //done for stallings
        .clock(clock),
        .reset(reset),
        .enable(!stallD),
        .clear(flushD), // for beq control hazard
        .instr(instr),
        .PCPlus4(PCPlus4F),
        .PC(PCF),
        .instrD(instrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D)
        );

ID_IE R2( // done for stall
        .clock(clock),
        .reset(reset),
        .clear(flushE),
        .inst(instrD),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D),
        .dest_regD(dest_reg),
        .read_reg1(read_reg1), // changed
        .read_reg2(read_reg2), // changed
        .ImmExtD(immediate_extendedD),
        .ALUControlD(ALUControlD),
        .ResultSrcD(ResultSrcD),
        .RegWriteD(RegWriteD),
        .MemWriteD(MemWriteD),
        .BranchD(BranchD),
        .jumpD(jumpD),
        .ALUSrcD(ALUSrcD),
        .read_data1E(read_data1E),
        .read_data2E(read_data2E),
        .ALUControlE(ALUControlE),
        .instrE(instrE),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E),
        .dest_regE(dest_regE),
        .read_reg1E(read_reg1E), // changed
        .read_reg2E(read_reg2E), // changed
        .ImmExtE(ImmExtE),
        .ResultSrcE(ResultSrcE),
        .RegWriteE(RegWriteE),
        .MemWriteE(MemWriteE),
        .BranchE(BranchE),
        .jumpE(jumpE),
        .ALUSrcE(ALUSrcE)
        );


IE_MEM R3(
        .clock(clock),
        .reset(reset),
        .RegWriteE(RegWriteE),
        .MemWriteE(MemWriteE),
        .ResultSrcE(ResultSrcE),
        .dest_regE(dest_regE),
        .PCPlus4E(PCPlus4E),
        .ALUResult(ALUResultE),
        .read_data2E(read_data2ForwardedE),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),
        .dest_regM(dest_regM),
        .PCPlus4M(PCPlus4M),
        .ALUResultM(ALUResultM),
        .read_data2M(read_data2M)
        );

MEM_WB R4(
        .clock(clock),
        .reset(reset),
        .RegWriteM(RegWriteM),
        .ALUResultM(ALUResultM),
        .dest_regM(dest_regM),
        .read_data(read_data),
        .PCPlus4M(PCPlus4M),
        .ResultSrcM(ResultSrcM),
        .RegWriteW(RegWriteW),
        .ALUResultW(ALUResultW),
        .dest_regW(dest_regW),
        .read_dataW(read_dataW),
        .PCPlus4W(PCPlus4W),
        .ResultSrcW(ResultSrcW)
        );

data_hazard hazard_unit (
                        .dest_regM(dest_regM),
                        .dest_regW(dest_regW),
                        .RegWriteM(RegWriteM),
                        .RegWriteW(RegWriteW),
                        .PCSrcE(PCSrcE),
                        .read_reg1E(read_reg1E),
                        .read_reg2E(read_reg2E),
                        .ResultSrcE(ResultSrcE),
                        .dest_regE(dest_regE),
                        .opcodeD(opcode),
                        .read_reg1D(read_reg1),
                        .read_reg2D(read_reg2),
                        .ForwardAE(ForwardAE),
                        .ForwardBE(ForwardBE),
                        .stallF(stallF),
                        .stallD(stallD),
                        .flushD(flushD),
                        .flushE(flushE)
                        );

ForwardA A(
        .read_data1E(read_data1E),
        .ForwardAE(ForwardAE),
        .ResultW(ResultW),
        .ALUResultM(ALUResultM),
        .SrcAE(SrcAE)
        );

ForwardB B(
        .read_data2E(read_data2E),
        .ForwardBE(ForwardBE),
        .ResultW(ResultW),
        .ALUResultM(ALUResultM),
        .SrcBE(read_data2ForwardedE)
        );
        
endmodule