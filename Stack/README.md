````markdown id="stack_readme_complete"
# 🔷 Parameterized Stack (LIFO) in Verilog

## 📖 Overview
This project implements a **parameterized Stack (Last-In-First-Out)** using Verilog HDL.  
The stack supports push and pop operations with configurable data width and depth.

---

## 🚀 Why Stack is Important
- 📦 Fundamental data structure in hardware systems  
- 🔄 Used in **function calls, recursion, interrupt handling**  
- 🧠 Helps in **temporary data storage (LIFO behavior)**  
- ⚡ Widely used in CPU control logic and datapath  

---

## ⚙️ Features
- Parameterized design:
  - `stackSize` (depth)
  - `dataSize` (bit-width)
- Push and Pop operations  
- Stack Pointer (SP) based control  
- Status flags:
  - `stackFull`
  - `stackEmpty`
- Handles:
  - Overflow (push when full)
  - Underflow (pop when empty)
- Supports simultaneous push & pop  

---

## 🧱 Internal Design

### 🔹 Memory
```verilog
reg [dataSize-1:0] stack [0:stackSize-1];
````

### 🔹 Stack Pointer (SP)

```verilog
reg [$clog2(stackSize):0] sp;
```

👉 SP always points to the **next empty location** in the stack.

---

## 🔄 Working of Stack

### 🔼 Push Operation (`push=1, pop=0`)

* Data is stored at `stack[sp]`
* Stack pointer increments

```text
stack[sp] = inputData
sp = sp + 1
```

---

### 🔽 Pop Operation (`push=0, pop=1`)

* Data is read from `stack[sp-1]`
* Stack pointer decrements

```text
outputData = stack[sp-1]
sp = sp - 1
```

---

### 🔁 Simultaneous Push & Pop (`push=1, pop=1`)

#### Case 1: Stack Empty (sp = 0)

* No valid data to pop
* Only push operation is performed

```text
stack[0] = inputData
outputData = inputData
sp = 1
```

---

#### Case 2: Stack Not Empty

* Pop old data from top
* Push new data at same location

```text
outputData = stack[sp-1]
stack[sp-1] = inputData
sp remains same
```

---

### ❌ No Operation (`push=0, pop=0`)

* Stack remains unchanged

---

## ⚠️ Edge Conditions

### 🔴 Stack Full

```verilog
stackFull = (sp == stackSize);
```

* Push operation is ignored when full

---

### 🔵 Stack Empty

```verilog
stackEmpty = (sp == 0);
```

* Pop operation is ignored when empty

---

## 🧪 Testbench

### 🔹 Task-Based Testing

```verilog
task testStack(...);
```

👉 Advantages:

* Clean and reusable test cases
* Easy to manage multiple scenarios
* Improves readability

---

### 🔹 Test Cases Covered

* Basic push operations
* Basic pop operations
* LIFO behavior verification
* Simultaneous push & pop
* Push when stack is full
* Pop when stack is empty
* Reset behavior
* Random data testing

---

## 📂 Project Structure

* `stack.v` → RTL Design
* `stackTb.v` → Testbench
* `README.md` → Documentation

---

## 📊 Simulation

* Verified using waveform and console output
* Correct LIFO behavior observed
* Edge cases handled successfully

---

## 🎯 Learning Outcomes

* Understanding LIFO data structure in hardware
* Stack pointer-based design
* Handling overflow and underflow conditions
* Writing parameterized RTL
* Task-based structured testbench

---

## 🔮 Future Improvements

* Add stack top (peek) operation
* Add error flags (overflow/underflow)
* Parameterized stack depth with runtime control
* Integration with CPU datapath

---

## 👨‍💻 Author

**Naitik Khariya**

```

---

# 🔥 Ye README powerful kyun hai?

👉 Isme:
- Concept ✔️  
- Working ✔️  
- Edge cases ✔️  
- Testbench ✔️  
- Interview theory ✔️  

👉 Matlab:
💯 **GitHub pe ye project strong impression dega**

---

Agar chaho next:
👉 Main tumhe iska **LinkedIn post (killer level 🔥)** bhi bana deta hoon
```
