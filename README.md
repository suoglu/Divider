# Divider

## Contents of Readme

1. About
2. Interface Description
3. Performance and Resource Utilization
4. Testing
5. Status Information

[![Repo on GitLab](https://img.shields.io/badge/repo-GitLab-6C488A.svg)](https://gitlab.com/suoglu/Divider)
[![Repo on GitHub](https://img.shields.io/badge/repo-GitHub-3D76C2.svg)](https://github.com/suoglu/Divider)

---

## About

This repository contains an integer divider module. And old and slower divider design can be found in [obsolete/](blob/main/obsolete/), but not suggested to be used.

## Interface Description

### Parameters

Following parameters can be used to modify the size of operation and the output flags.

|Parameter|Possible Values|Description|
| :----: | :-----:  | ---- |
| `WIDTH` | integer | Operation size |
| `CACHING` | bool | Enable result caching |
| `INIT_VLD` | bool | In reset state set valid flag |

`CACHING`: When enabled, if same operands as previous calculation given, directly set valid flag. This requires additional logic and registers.

### Ports

Ports of the all modules/IPs named in same manner.

|   Port   | Type | Width | Description | Notes |
| :------: | :----: | :----: | :----: | :-----:  | ---- |
| `clk` | I | 1 | System Clock | |
| `rst` | I | 1 | System Reset | |
| `start` | I | 1 | Start Calculation | |
| `dividend` | I | `WIDTH`| Dividend Operand | |
| `divisor` | I | `WIDTH`| Divisor Operand | |
| `quotient` | O | `WIDTH`| Quotient Result | |
| `remainder` | O | `WIDTH`| Remainder Result | |
| `zeroErr` | O | 1 | Divide by Zero Error | |
| `valid` | O | 1 | Outputs are Valid | |

I: Input  O: Output

## Performance and Resource Utilization

All values in this section are for Xilinx Artix-7 (_XC7A100TCSG324-1_) FPGA with caching enabled and init valid disabled.

### 32 bit divider

- Utilization after synthesis: 125 LUT as Logic and 108 Register as Flip Flop
- Maximum tested clock frequency (with input output registers): 200 MHz

### 64 bit divider

- Utilization after synthesis: 237 LUT as Logic and 205 Register as Flip Flop
- Maximum tested clock frequency (with input output registers): 150 MHz

## Testing

Files related to testing can be found in [Testing](blob/main/Testing) directory. Test block diagram contains a VIO and a ILA connected to divider module. Each connection contains a pipeline register.

### Status Information

- Simulation: 27 July 2023 with [Vivado Simulator 2021.1.1](https://www.xilinx.com/products/design-tools/vivado.html).
- Test: 27 July 2023 with [Digilent Arty A7](https://digilent.com/reference/programmable-logic/arty-a7/reference-manual)
