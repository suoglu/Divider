`timescale 1ns / 1ps
/* ----------------------------------------- *
 * Title       : Divider                     *
 * Project     : Divider                     *
 * ----------------------------------------- *
 * File        : tb.v                        *
 * Author      : Yigit Suoglu                *
 * Last Edit   : 27/07/2023                  *
 * Licance     : CERN-OHL-W                  *
 * ----------------------------------------- *
 * Description : Sequential divider hardware *
 * ----------------------------------------- */

module tb;

  reg clk, rst;

  always begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  initial begin
    rst = 0;
    @(posedge clk); #1;
    rst = 1;
    @(posedge clk); #1;
    rst = 0;
  end

  localparam WIDTH = 32;
  reg start = 0;
  reg [WIDTH-1:0] dividend = 0;
  reg [WIDTH-1:0] divisor = 0;
  wire [WIDTH-1:0] remainder, quotient;
  wire valid, zeroErr;

  wire [WIDTH-1:0] remainder_ref = dividend % divisor;
  wire [WIDTH-1:0] quotient_ref  = dividend / divisor;

  wire error = valid && (remainder_ref != remainder || quotient_ref != quotient) && !(zeroErr && divisor == 0);

  divider #(.WIDTH(WIDTH), .CACHING(1), .INIT_VLD(0))
       uut (.clk(clk), .rst(rst), .start(start), 
            .dividend(dividend), .divisor(divisor), .quotient(quotient), .remainder(remainder), 
            .zeroErr(zeroErr), .valid(valid));

  initial begin
    repeat(5) @(posedge clk); #1;
    dividend = 12344235;
    divisor = 2343;
    start = 1;
    @(posedge clk); #1;
    start = 0;
    while(!valid) @(posedge clk); #1;
    repeat(5) @(posedge clk); #1;
    dividend = {WIDTH{1'b1}};
    divisor = 1;
    start = 1;
    @(posedge clk); #1;
    start = 0;
    while(!valid) @(posedge clk); #1;
    repeat(5) @(posedge clk); #1;
    dividend = 4624653;
    divisor = 0;
    start = 1;
    @(posedge clk); #1;
    start = 0;
    while(!valid) @(posedge clk); #1;
    repeat(5) @(posedge clk); #1;
    dividend = 5657;
    divisor = 68686265;
    start = 1;
    @(posedge clk); #1;
    start = 0;
    while(!valid) @(posedge clk); #1;
    repeat(5) @(posedge clk); #1;
    dividend = 95665724354;
    divisor = 34;
    start = 1;
    @(posedge clk); #1;
    start = 0;
    while(!valid) @(posedge clk); #1;
    repeat(5) @(posedge clk); #1;
    dividend = 3**10;
    divisor = 3;
    start = 1;
    @(posedge clk); #1;
    start = 0;
    while(!valid) @(posedge clk); #1;
    repeat(5) @(posedge clk); #1;
    dividend = 3**10;
    divisor = 3;
    start = 1;
    @(posedge clk); #1;
    start = 0;
    while(!valid) @(posedge clk); #1;
    repeat(5) @(posedge clk); #1;
    $finish;
  end
endmodule