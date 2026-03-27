# 🔷 8×8 Register File in Verilog

## 📖 Overview

This project implements an **8×8 Register File** using Verilog HDL.
It consists of **8 registers (each 8-bit wide)** with:

* **Two read ports**
* **One write port**

This design is commonly used in **CPU datapath architectures** for efficient data handling.

---

## 🚀 Why Register File is Important

* Core component of **CPU datapath**
* Enables **fast data access**
* Stores intermediate results for ALU operations
* Supports **simultaneous read and write operations**

---

## ⚙️ Features

* 8 Registers × 8-bit each
* 2 Read Ports → `readAddr1`, `readAddr2`
* 1 Write Port → `writeAddr`, `writeData`
* **Synchronous Write** (on clock edge)
* **Combinational Read**
* **Bypass Logic** for read-after-write handling

---

## 🏗️ Design Details

### 🔹 Write Operation

* Triggered on **posedge clk**
* Controlled by `writeEnable`
* Data is written into register selected by `writeAddr`

---

### 🔹 Read Operation

* Implemented using **combinational logic**
* No clock required
* Data is read from:

  * `readAddr1 → readData1`
  * `readAddr2 → readData2`

---

## 🧠 Bypass Logic (Read-After-Write Handling)

### ❓ Problem

If a register is written and read in the **same clock cycle**,
the updated value may not be available immediately due to timing.

---

### ✅ Solution (Bypass / Forwarding)

The design forwards the write data directly to the output:

```verilog
if (writeEnable && (writeAddr == readAddr1))
    readData1 = writeData;
```

---

## 🔥 Why It Matters

* Prevents **data hazards**
* Widely used in **CPU pipelines**
* Improves overall **performance**

---

## 🧪 Testbench

### 🔹 Task-Based Testing

The testbench uses a reusable task:

```verilog
task testRegisterFile;
```

### 🔹 Advantages of Task

* Reduces repetitive code
* Improves readability
* Makes testbench reusable

---

### 🔹 Self-Checking Mechanism

* Automatically compares output with expected values
* Displays **success/failure messages**

---

### 🔹 Edge Cases Covered

* Write operations
* Read-after-write (bypass case)
* Simultaneous read and write
* `writeEnable = 0` case
* **X-state detection**

---

## 📂 Project Structure

```
RegisterFile.v   → RTL Design  
testBench.v      → Testbench  
README.md        → Documentation  
```

---

## 📊 Simulation

* Verified using **waveforms**
* Console-based output validation
* All test cases passed using structured testbench

---

## 🎯 Learning Outcomes

* Register File architecture
* Multi-port memory design
* Data hazard handling using bypass logic
* Task-based testbench design
* Self-checking verification

---

## 🔮 Future Improvements

* Parameterized design (scalable size)
* Multiple write ports
* Integration with ALU
* Full pipeline datapath design

---

## 👨‍💻 Author

**Naitik Khariya**

---