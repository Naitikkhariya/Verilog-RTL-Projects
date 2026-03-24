# 🔷 8-bit Barrel Shifter in Verilog

## 📖 Overview
This project implements an **8-bit Barrel Shifter** using Verilog HDL.  
A barrel shifter is a combinational circuit that can shift or rotate data by multiple bit positions in a single clock cycle.

---

## 🚀 Why Barrel Shifter is Important
- ⚡ **Faster than iterative shifting** (no clock cycles needed per shift)
- 🧠 Used in **CPU datapath, ALU, DSP systems**
- 🔄 Enables **multi-bit shifting in one operation**
- 📈 Improves overall system performance in processors

---

## ⚙️ Features
- 8-bit input data
- 3-bit shift amount (0–7)
- Supports:
  - Logical Shift
  - Arithmetic Shift
  - Rotate Shift
- Direction control:
  - Left Shift
  - Right Shift

---

## 🔢 Shift Modes

### 1. Logical Shift
- Fills shifted bits with `0`
- Used for unsigned data

### 2. Arithmetic Shift
- Used for signed numbers (2’s complement)
- **Right Shift:** preserves sign (MSB replicated)
- **Left Shift:** behaves like logical shift (may change sign)

### 3. Rotate Shift
- Bits wrap around from one end to the other

---

## 🧠 Important Concept (Interview Point)

### ❓ Why Arithmetic Right Shift preserves sign?
In signed numbers (2’s complement), the **MSB represents the sign bit**:
- `0` → Positive
- `1` → Negative  

👉 During **right shift**, if we don’t preserve the MSB:
- A negative number may become positive ❌

👉 So we replicate the MSB:

---

### ❓ Why Arithmetic Left Shift does NOT preserve sign?
👉 Left shift moves bits towards MSB:
- New bits come from LSB side
- MSB may change naturally

👉 This is acceptable because:
- Left shift is equivalent to **multiplication by 2**
- Overflow may occur → sign change is expected

👉 So:
- ✔ Right shift → preserve sign  
- ❌ Left shift → overflow allowed  

---

## 🏗️ Design Approach
- Multi-stage shifting:
  - Stage 0 → shift by 1
  - Stage 1 → shift by 2
  - Stage 2 → shift by 4
- Combines stages based on shift amount bits
- Efficient hardware implementation

---

## 🔧 Inputs & Outputs

### Inputs:
- `Input_data [7:0]`
- `Shift_amt [2:0]`
- `Shift_mode [1:0]`
- `dir`

### Output:
- `output_data [7:0]`

---

## 🔢 Opcode / Mode Table

| Mode | Operation |
|------|----------|
| 00   | Logical Shift |
| 01   | Arithmetic Shift |
| 10   | Rotate Shift |

| dir | Direction |
|-----|----------|
| 0   | Left Shift |
| 1   | Right Shift |

---

## 🧪 Testbench
- Covers:
  - Logical, Arithmetic, Rotate modes
  - Left & Right shift
  - Shift by 0 (edge case)
  - Maximum shift (7)
- Includes error checking using `$display`

---

## 📂 Project Structure
- `barrelShifter.v` → RTL Design  
- `testBench.v` → Testbench  
- `README.md` → Documentation  

---

## 📊 Simulation
- Verified using waveform analysis
- All modes tested with multiple inputs

---

## 🎯 Learning Outcomes
- Understanding of Barrel Shifter architecture  
- Multi-stage combinational design  
- Signed vs unsigned shifting concepts  
- Writing structured RTL and testbench  

---

## 🔮 Future Improvements
- Parameterized bit-width design  
- Pipelined barrel shifter  
- Integration with ALU / datapath  
- Power and area optimization  

---

## 👨‍💻 Author
Naitik Khariya