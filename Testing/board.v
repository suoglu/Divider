//yigit suoglu
//board file
`include "Source/divider_param.v"
`include "Source/divider_8bit.v"
`include "Testing/debouncer.v"
`include "Testing/ssd_util.v"
`timescale 1ns / 1ps
`timescale 1ns / 1ps

module board(clk, btnC, btnU, btnD, sw, led, seg, an);
input clk, btnC, btnU, btnD; //clock, start, reset, change uut
input [15:0] sw; //{dividend, divisor}
output [15:0] led;
output [6:0] seg; //gfedcba
output [3:0] an;
wire rst, strt, not_valid, idle, not_valid_f, idle_f, not_valid_p, idle_p, swtch, aggre;
wire [7:0] dividend, divisor, quotient_f, remainder_f, quotient_p, remainder_p, quotient, remainder;
wire a, b, c, d, e, f, g;
reg output_mode; //0 for 8-bit fixed, 1 for parameterized
assign rst = btnU;
assign dividend = sw[15:8];
assign divisor = sw[7:0];
assign seg = {g, f, e, d, c, b, a};
assign led = {output_mode, aggre, 12'b0, not_valid, idle};
assign aggre = (quotient_f == quotient_p) & (remainder_p == remainder_f) & (not_valid_f == not_valid_p) & (idle_p == idle_f);

//testing mode
always@(posedge clk or posedge rst)
    begin
        if(rst)
            begin
                output_mode <= 0;
            end
        else
            begin
                output_mode <= (swtch) ? ~output_mode : output_mode;
            end
    end


//mux for output selection
assign quotient = (output_mode) ? quotient_p : quotient_f;
assign remainder = (output_mode) ? remainder_p : remainder_f;
assign not_valid = (output_mode) ? not_valid_p : not_valid_f;
assign idle = (output_mode) ? idle_p : idle_f;


//utility modules
ssdMaster ssdDriver(clk, rst, 4'b1111, remainder[3:0], remainder[7:4], quotient[3:0], quotient[7:4], a, b, c, d, e, f, g, an);
debouncer dbunce0(clk, rst, btnC, strt);
debouncer dbunce1(clk, rst, btnD, swtch);

//uut
divider_param #(8,3) uut1(clk, rst, strt, dividend, divisor, quotient_p, remainder_p, not_valid_p, idle_p);
divider_8bit uut0(clk, rst, strt, dividend, divisor, quotient_f, remainder_f, not_valid_f, idle_f);
    
endmodule//board
