//yigit suoglu 
// parameterised divider module defarult 16bit
// dividend = divisor * quotient + remainder
`timescale 1ns / 1ps

module divider_param#(parameter BITSIZE = 16)(clk, rst, strt, dividend, divisor, quotient, remainder, infinite, idle);
    localparam INDEXSIZE = $clog2(BITSIZE);
    localparam IDLE = 2'b00, PRECALC = 2'b01, CALC = 2'b11, POSTCALC = 2'b10;
    
    input clk, rst, strt;
    input [(BITSIZE-1):0] dividend, divisor;
    output reg [(BITSIZE-1):0] quotient, remainder;
    output infinite; //True if divison result is not valid
    output idle; //True when ready to
    reg [BITSIZE:0] dividend_reg, divisor_reg; //extra bit for sign check
    wire update_divident; //update dividend value after test substraction, little typo 
    wire sign_of_test_sub; //0 for positive, 1 for negative
    wire [BITSIZE:0] test_sub_res; //result of test substraction
    reg [1:0] state; //00: idle, 01: precalculate, 11: calcuate
    reg [(INDEXSIZE-1):0] q_index;

    assign infinite = ~|divisor; //not valid if divisor is 0
    assign idle = ~|state; //state 00
    assign test_sub_res = dividend_reg + (~divisor_reg) + 9'd1; //test subtraction
    assign sign_of_test_sub = ~test_sub_res[BITSIZE];
    assign update_divident = sign_of_test_sub;

    //state transactions
    always@(posedge clk or posedge rst)
        begin
            if(rst)
                begin
                    state <= IDLE;
                end
            else
                begin
                    case(state)
                        IDLE:
                            begin
                                if(strt)
                                    begin
                                        state <= (infinite) ? POSTCALC : ((divisor[BITSIZE-1]) ? CALC : PRECALC);
                                    end
                            end
                        PRECALC:
                            begin
                                state <= (divisor_reg[BITSIZE-2]) ? CALC : PRECALC;
                            end
                        CALC:
                            begin
                               state <= (q_index == 0) ? POSTCALC : CALC; 
                            end
                        POSTCALC:
                            begin
                                state <= IDLE;
                            end
                    endcase
                    
                end
        end

    //divisor register
    always@(posedge clk)
        begin
            case(state)
                IDLE:
                    begin
                        divisor_reg <= {1'b0, divisor};
                    end
                PRECALC:
                    begin
                        divisor_reg <= divisor_reg << 1;
                    end
                CALC:
                    begin
                        divisor_reg <= divisor_reg >> 1;
                    end
            endcase
        end

    //handle reminder
    always@(posedge clk)
        begin //remaining number at divident is the remmainder
            remainder <= (state == POSTCALC) ? dividend_reg[(BITSIZE-1):0] : remainder; 
        end
    

    
    
    //handle dividend_reg
    always@(posedge clk)
        begin
            case(state)
                IDLE://while at idle state update dividend register
                    begin
                        dividend_reg <= {1'b0, dividend};
                    end
                CALC:
                    begin
                        dividend_reg <= (update_divident) ? test_sub_res : dividend_reg;
                    end
            endcase
        end
    
    //handle quotient index
    always@(posedge clk)
        begin
            case(state)
                IDLE:
                    begin
                        q_index <= 0;
                    end
                PRECALC:
                    begin
                        q_index <= q_index + 1;
                    end
                CALC:
                    begin
                        q_index <= q_index - 1;
                    end
            endcase
        end 
    

    //handle quotient 
    always@(posedge clk)
        begin
            case(state)
                PRECALC: //at pre calculate state reset quotient
                    begin
                        quotient <= 0;
                    end
                CALC: 
                    begin
                        quotient[q_index] <= sign_of_test_sub;
                    end
                POSTCALC: 
                    begin
                        quotient[(BITSIZE-1):1] <= (divisor_reg[BITSIZE-2]) ? 0 : quotient[(BITSIZE-1):1];
                    end
            endcase
        end
endmodule
