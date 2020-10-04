//testbench for divider

`timescale 1ns / 1ps

module testbench();
    reg clk, rst, strt;
    reg [7:0] dividend, divisor;
    wire [7:0] quotient, remainder;
    wire not_valid, idle;

    divider_8bit uut(clk, rst, strt, dividend, divisor, quotient, remainder, not_valid, idle);

    always #5 clk <= ~clk;

    initial
        begin
             $dumpfile("divider_8bit.vcd");
             $dumpvars(0, clk);
             $dumpvars(1, rst);
             $dumpvars(2, not_valid);
             $dumpvars(3, idle);
             $dumpvars(4, strt);
             $dumpvars(5, dividend);
             $dumpvars(6, divisor);
             $dumpvars(7, quotient);
             $dumpvars(8, remainder);
        end

    initial
        begin
            clk <= 0;
            rst <= 0;
            strt <= 0;
            dividend <= 8'd0;
            divisor <= 8'd0;
        end
endmodule//testbench