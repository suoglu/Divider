//testbench for divider
`include "Source/divider_param.v"
`include "Source/divider_8bit.v"
`timescale 1ns / 1ps

module testbench();
    reg clk, rst, strt;
    reg [7:0] dividend, divisor;
    wire [7:0] quotient_f, remainder_f, quotient_p, remainder_p;
    wire not_valid_f, idle_f, not_valid_p, idle_p;
    wire both_equal; //to check whether both modules output same

    assign both_equal = (quotient_f == quotient_p) & (remainder_f == remainder_p) & (not_valid_f == not_valid_p) & (idle_f == idle_p);

    divider_8bit uut0(clk, rst, strt, dividend, divisor, quotient_f, remainder_f, not_valid_f, idle_f);
    divider_param uut1(clk, rst, strt, dividend, divisor, quotient_p, remainder_p, not_valid_p, idle_p);

    always #5 clk <= ~clk;

    initial
        begin
             $dumpfile("divider_8bit.vcd");
             $dumpvars(0, clk);
             $dumpvars(1, rst);
             $dumpvars(2, not_valid_f);
             $dumpvars(3, idle_f);
             $dumpvars(4, strt);
             $dumpvars(5, dividend);
             $dumpvars(6, divisor);
             $dumpvars(7, quotient_f);
             $dumpvars(8, remainder_f);
             $dumpvars(9, quotient_p);
             $dumpvars(10, remainder_p);
             $dumpvars(11, both_equal);
             $dumpvars(12, not_valid_p);
             $dumpvars(13, idle_p);
        end

    initial
        begin
            clk <= 0;
            rst <= 0;
            strt <= 0;
            dividend <= 8'd0;
            divisor <= 8'd0;
            #3
            rst <= 1;
            #10
            rst <= 0;
            #10 //division without remainder 1 #1
            dividend <= 8'd25;
            divisor <= 8'd5;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #200 //division without remainder 2 #2
            dividend <= 8'd126;
            divisor <= 8'd3;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #200 //division without remainder 3 #3
            dividend <= 8'd135;
            divisor <= 8'd45;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #200//division with remainder 1 #4
            dividend <= 8'd200;
            divisor <= 8'd91;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #200//division with remainder 2 #5
            dividend <= 8'd142;
            divisor <= 8'd11;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #200//division with remainder 3 #6
            dividend <= 8'd177;
            divisor <= 8'd77;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #200//dividend max #7
            dividend <= 8'b11111111;
            divisor <= 8'd61;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #200//dividend and divisor max #8
            dividend <= 8'b11111111;
            divisor <= 8'b11111111;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #200//dividend = divisor #9
            dividend <= 8'd123;
            divisor <= 8'd123;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #200//divisor is 0 #10
            dividend <= 8'd96;
            divisor <= 8'd0;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #200//dividend is 0 #11
            dividend <= 8'd0;
            divisor <= 8'd21;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #200//dividend < divisor 1 #12
            dividend <= 8'd100;
            divisor <= 8'd188;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #200//dividend < divisor 2 #13
            dividend <= 8'd78;
            divisor <= 8'd250;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #200//dividend < divisor 3 #14
            dividend <= 8'd165;
            divisor <= 8'd193;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #200//start stays high longer #15
            dividend <= 8'd81;
            divisor <= 8'd21;
            #10
            strt <= 1;
            #100
            strt <= 0;
            #110//dividend and divisor changes during operation #16
            dividend <= 8'd200;
            divisor <= 8'd20;
            #10
            strt <= 1;
            #10
            strt <= 0;
            #30
            dividend <= 8'd99;
            divisor <= 8'd55;
            #170
            $finish;
        end
endmodule//testbench