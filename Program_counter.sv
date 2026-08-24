module program_counter (
    input logic clock, reset, enable,
    input logic [31:0] PCNext,
    output logic [31:0] PCF
);

always_ff @( posedge clock or posedge reset ) begin 
    if(reset)
        PCF <= 0; 
    else if(!enable)
        PCF <= PCF;
    else
        PCF <= PCNext;
end
    
endmodule