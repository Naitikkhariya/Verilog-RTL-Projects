# 🔷 Parameterized RAM in Verilog

## 📖 Overview

This project implements a **parameterized RAM (Random Access Memory)** using Verilog HDL.
The design supports configurable memory depth and data width with **synchronous read and write operations**.

---

## 🚀 Why RAM is Important

* 📦 Primary storage element in digital systems
* 🧠 Used to store instructions and data in processors
* ⚡ Enables fast data access using address-based indexing
* 🔄 Core component of memory hierarchy (Cache, RAM, etc.)

---

## ⚙️ Features

* Parameterized design:

  * `ramWidth` → memory depth
  * `dataSize` → data width
* Synchronous read and write (posedge clk)
* Address-based access
* Supports simultaneous read and write

---

## 🧱 Internal Design

### 🔹 Memory Array

```verilog
reg [dataSize-1:0] ram [0:ramWidth-1];
```

---

### 🔹 Addressing

```verilog
input wire [$clog2(ramWidth)-1:0] add;
```

👉 Address selects the memory location for read/write.

---

## 🔄 Working of RAM

### 🔹 Write Operation (`write_en = 1`)

* Data is written to memory at given address

```text
ram[address] = data_in
```

---

### 🔹 Read Operation (`read_en = 1`)

* Data is read from memory at given address

```text
data_out = ram[address]
```

---

## 🧠 Important Concept: Simultaneous Read & Write

### ❓ Case: `read_en = 1` and `write_en = 1`

👉 In this design:

```verilog
if(read_en)
    data_out <= ram[add];

if(write_en)
    ram[add] <= data_in;
```

---

### 🔥 Behavior: **Write-After-Read**

* First → old data is read
* Then → new data is written

```text
Cycle Behavior:
1. Read old value from RAM
2. Write new value to same address
```

---

### 🧠 Why This Happens?

* Non-blocking assignments (`<=`) execute in parallel
* RHS (right-hand side) is evaluated before update
* So read gets old value

---

### 📌 Example

```text
Address = 3
Old value = 23

Cycle:
Read → data_out = 23
Write → ram[3] = new_data

Next read → new_data
```

---

## 🧪 Testbench

### 🔹 Task-Based Testing

```verilog
task RamTest(...);
```

👉 Advantages:

* Reusable test cases
* Cleaner code structure
* Easy scenario testing

---

### 🔹 Test Cases Covered

* Write operations
* Read operations
* Read from uninitialized memory
* Simultaneous read & write
* Different address access patterns

---

## 📂 Project Structure

* `RAM.v` → RTL Design
* `tb.v` → Testbench
* `README.md` → Documentation

---

## 📊 Simulation

* Verified using waveform and console output
* Confirmed correct read/write behavior
* Verified write-after-read condition

---

## 🎯 Learning Outcomes

* Memory design using Verilog
* Address-based data access
* Synchronous read/write behavior
* Understanding write-after-read mechanism
* Task-based testbench design

---

## 🔮 Future Improvements

* Add byte-enable support
* Dual-port RAM design
* Memory initialization
* Integration with CPU datapath

---

## 👨‍💻 Author

**Naitik Khariya**
