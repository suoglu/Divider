# Divider

This repository contains a 8-bit integer divider module. Divider provides results in form of *dividend = divisor \* quotient + remainder*, i.e. given a dividend and a divisor, module outputs an integer quotient and remainder, not a floating point result.

Testing will be done on [Digilent Basys 3](https://reference.digilentinc.com/reference/programmable-logic/basys-3/reference-manual) FPGA with [board.v](https://github.com/suoglu/divider/blob/main/Testing/board.v). Interface follows as:

* `Reset`: Upper Button (btnU)
* `Start`: Center Button (btnC)
* `Dividend`: 8 leftmost switches (sw[15:8])
* `Divisor`: 8 rightmost switches (sw[7:0])
* `Quotient`: 2 leftmost hexadecimal digits of ssd
* `Remainder`: 2 rightmost hexadecimal digits of ssd
* `idle`: Rightmost led (led[0])
* `Not valid`: 2nd rightmost led (led[1])
 

**8-Bit**

* Simulation: with Icarus Verilog, 5 Oct 2020
    * Test cases can be found on [tb_8bit.v](https://github.com/suoglu/divider/blob/main/Simulation/tb_8bit.v).
* On FPGA: 5 Oct 2020
    * Test cases: 2/2, 64/2, 255/255, 85/5, 0/69, 166/0, 176/176, 176/182, 128/181, 129/133, 229/29, 141/90, 173/10, 223/17, 240/80, 240/160
