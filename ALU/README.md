# 🔷 8-bit ALU Design in Verilog

## 📖 Overview
This project implements an **8-bit Arithmetic Logic Unit (ALU)** using Verilog HDL.  
The ALU performs arithmetic, logical, and shift operations based on a 4-bit opcode.

---

## ⚙️ Features
- 8-bit inputs: A, B
- 4-bit opcode control
- Supported operations:
  - Addition
  - Subtraction
  - AND
  - OR
  - XOR
  - NOT
  - Shift Left
  - Shift Right

---

## 🧠 Flags Implemented
- **Carry** → For addition and shift operations  
- **Borrow** → For subtraction  
- **Zero** → When result = 0  
- **Negative** → MSB of result  
- **Overflow** → Signed arithmetic overflow  

---

## 🏗️ Design Details
- Combinational ALU (`always @(*)`)
- Case-based opcode decoding
- Temporary 9-bit register used for carry handling
- Separate logic for overflow detection

---

## 🔢 Opcode Table

| Opcode | Operation     |
|--------|--------------|
| 0000   | ADD          |
| 0001   | SUB          |
| 0010   | AND          |
| 0011   | OR           |
| 0100   | XOR          |
| 0101   | NOT (A)      |
| 0110   | SHIFT LEFT   |
| 0111   | SHIFT RIGHT  |

---

## 🧪 Testbench
The testbench verifies:
- Basic operations
- Overflow condition (127 + 1)
- Carry generation (FF + 01)
- Zero flag (A == B in subtraction)
- Negative result

Uses `$monitor` for real-time output tracking.

---

## 📂 Files
- `ALU.v` → RTL Design  
- `tb.v` → Testbench  

---

## 🚀 Simulation
Run using:
- ModelSim  
- Vivado Simulator  
- Icarus Verilog  

---

## 🎯 Learning Outcomes
- ALU architecture understanding  
- Opcode-based hardware control  
- Flag generation logic  
- Writing clean RTL + Testbench  

---

## 🔮 Future Improvements
- Add multiply/divide operations  
- Parameterized bit-width ALU  
- Pipelined ALU design  
- Integration with Register File / CPU Datapath  

---

## 📌 Author
Naitik Khariya