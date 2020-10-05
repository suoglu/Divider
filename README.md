# Divider

This repository contains a 8-bit integer divider module. Divider provides results in form of *dividend = divisor \* quotient + remainder*, i.e. given a dividend that is larger then provided divisor module outputs an integer quotient and remainder, not a floating point result.

Testing will be done on [Digilent Basys 3](https://reference.digilentinc.com/reference/programmable-logic/basys-3/reference-manual) FPGA.

**8-Bit**

* Simulation: with Icarus Verilog on 5 Oct 2020
    * Test cases can be found on [tb_8bit.v](https://github.com/suoglu/divider/blob/main/Simulation/tb_8bit.v).
