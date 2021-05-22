# Divider

## About

This repository contains a 8-bit integer divider module. Divider provides results in form of *dividend = divisor \* quotient + remainder*, i.e. given a dividend and a divisor, module outputs an integer quotient and remainder, not a floating point result.

## Simulation and Testing

### Testing Information

Testing will be done on [Digilent Basys 3](https://reference.digilentinc.com/reference/programmable-logic/basys-3/reference-manual) FPGA with [board.v](https://github.com/suoglu/divider/blob/main/Testing/board.v) (for 8 bit modules).

#### 8-Bit Interface

* `Reset`: Upper Button (btnU)
* `Start`: Center Button (btnC)
* `Switch UUT`: Lower Button (btnD)
* `Dividend`: 8 leftmost switches (sw[15:8])
* `Divisor`: 8 rightmost switches (sw[7:0])
* `Quotient`: 2 leftmost hexadecimal digits of ssd
* `Remainder`: 2 rightmost hexadecimal digits of ssd
* `Selected UUT`: Leftmost led (led[15]), 1 for the parameterised UUT and 0 for the fixed 8-bit UUT
* `UUT Compare`: 2nd leftmost led (led[14]), both UUT have the same output
* `idle`: Rightmost led (led[0])
* `Not valid`: 2nd rightmost led (led[1])

### Results

#### 8-Bit

* Simulation: with Icarus Verilog, 5 Oct 2020
  * Test cases can be found on [tb_8bit.v](blob/main/Simulation/tb_8bit.v).
* On FPGA: 5 Oct 2020
  * Test cases: 2/2, 64/2, 255/255, 85/5, 0/69, 166/0, 176/176, 176/182, 128/181, 129/133, 229/29, 141/90, 173/10, 223/17, 240/80, 240/160

#### Parameterised

* Simulation: with Icarus Verilog
  * 8-bit: 5 Oct 2020, test cases can be found on [tb_8bit.v](blob/main/Simulation/tb_8bit.v).
  * 32-bit: 6 Oct 2020, test cases can be found on [tb_32bit.v](blob/main/Simulation/tb_32bit.v).
* On FPGA:
  * 8-bit: 6 Oct 2020, Test cases: 240/0, 0/179, 132/12, 250/25, 202/61, 28/165, 40/229, 174/5, 222/21, 230/53, 255/255, 0/255, 255/0, 225/255, 255/13
