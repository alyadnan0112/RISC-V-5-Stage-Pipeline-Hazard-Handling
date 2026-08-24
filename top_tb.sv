`timescale 1ns / 1ps

module top_tb;
logic clock, reset;

top dut (
    .clock(clock),
    .reset(reset)
);

always #5 clock = ~clock;

initial begin
    clock = 0;
    reset = 1;
    #10;
    reset = 0;

    #1000;

    $finish;
end
endmodule
