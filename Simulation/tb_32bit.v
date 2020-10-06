//testbench for divider
`include "Source/divider_param.v"
`timescale 1ns / 1ps

module testbench();
    reg clk, rst, strt;
    reg [31:0] dividend, divisor;
    wire [31:0] quotient, remainder;
    wire not_valid, idle;


    divider_param #(32,5) uut0(clk, rst, strt, dividend, divisor, quotient, remainder, not_valid, idle);

    always #5 clk <= ~clk;

    initial
        begin
             $dumpfile("divider_32bit.vcd");
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
            dividend <= 32'd0;
            divisor <= 32'd0;
            #3
            rst <= 1;
            #10
            rst <= 0;
            #10 //division without remainder 1 #1
            dividend <= 32'd12_339;
            divisor <= 32'd9;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #1000//division without remainder 2 #2
            dividend <= 32'd165_841_528;
            divisor <= 32'd20_730_191;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #1000//division without remainder 3 #3
            dividend <= 32'd2_959_967_408;
            divisor <= 32'd45_854;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #1000//division with remainder 1 #4
            dividend <= 32'd3_924_643_852;
            divisor <= 32'd354_928;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #1000//division with remainder 2 #5
            dividend <= 32'd4_111_874_375;
            divisor <= 32'd2_837_458_014;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #1000//division with remainder 3 #6
            dividend <= 32'd3_583_758_037;
            divisor <= 32'd783_098;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #1000//dividend max #7
            dividend <= 32'hffffffff;
            divisor <= 32'h8a748;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #1000//dividend and divisor max #8
            dividend <= 32'hffffffff;
            divisor <= 32'hffffffff;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #1000//dividend = divisor #9
            dividend <= 32'ha76f81bc;
            divisor <= 32'ha76f81bc;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #1000//dividend is 0 #10
            dividend <= 32'd0;
            divisor <= 32'h9382bc2;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #1000//divisor is 0 #11
            dividend <= 32'habc6310;
            divisor <= 32'd0;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #1000//dividend < divisor 1 #12
            dividend <= 32'hf09bc1;
            divisor <= 32'hfaff1f5f;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #1000//dividend < divisor 2 #13
            dividend <= 32'habcd;
            divisor <= 32'h9837bc;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #1000
            $finish;
        end
endmodule//testbench