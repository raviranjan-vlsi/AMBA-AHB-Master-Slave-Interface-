# 🚀 AMBA AHB Master–Slave Interface | RTL Design & Protocol Study  

Hi! 👋  
This project is part of my learning in **VLSI RTL Design**, where I implemented and studied the **AMBA AHB protocol** by designing both an **AHB Master and AHB Slave** in Verilog.

The focus of this project is to understand how real on-chip communication works, especially the **address/data phase separation and handshake mechanism** defined in the AHB protocol.

---

## 📌 Project Highlights

- Designed **AHB Master and AHB Slave** in Verilog  
- Implemented **FSM-based control logic** for bus transactions  
- Supported **burst write transfer (INCR4)**  
- Integrated **FIFO (16-depth)** for data buffering in master  
- Verified protocol behavior using **waveform analysis (GTKWave)**  

---

## 🧠 What I Learned

Through this project, I gained practical understanding of:

- AMBA AHB protocol fundamentals  
- Address phase vs Data phase (pipelined behavior)  
- Role of **HTRANS (IDLE, NONSEQ, SEQ)**  
- Importance of **HREADY handshake**  
- FSM design for protocol control  
- Integration of FIFO with bus-based architecture  
- Debugging timing and protocol issues using waveforms  

---

## 🏗️ Architecture Overview

The design consists of:

- 🔹 **AHB Master**
  - Generates control signals and transactions  
  - Reads data from FIFO and sends it to the bus  

- 🔹 **FIFO (16-depth)**
  - Buffers incoming data before transmission  
  - Ensures smooth burst transfers  

- 🔹 **AHB Slave (Memory Model)**
  - Receives data from master  
  - Responds using HREADY and HRESP  

---

## 🔄 FSM Operation

- **IDLE** → Wait for enable  
- **NONSEQ** → First transfer of burst  
- **SEQ** → Remaining transfers  

---

## 📡 AHB Signals Used

### Address & Control
- `HADDR`  : Address bus  
- `HWRITE` : Write control  
- `HSIZE`  : Transfer size (32-bit)  
- `HBURST` : Burst type (INCR4)  
- `HTRANS` : Transfer type  

### Data
- `HWDATA` : Write data  
- `HRDATA` : Read data  

### Handshake
- `HREADY` : Transfer completion signal  
- `HRESP`  : Response signal  

---

## 🧪 Simulation & Verification

- ✔️ Testbench implemented for burst write  
- ✔️ Verified using **GTKWave**  
- ✔️ Observed:
  - Correct NONSEQ → SEQ transition  
  - Proper address increment  
  - FIFO data transfer behavior  
  - Handshake synchronization using HREADY  

---

## ⚠️ Limitations (Learning Version)

- Only **write transactions** implemented  
- Only **INCR4 burst** supported  
- No **read operation yet**  
- No **wrap burst support**  
- Limited **pipelining implementation**  
- Basic **HRESP handling**  

---

## 🔮 Future Improvements

- Add **read transfer support**  
- Implement **WRAP burst modes**  
- Add proper **AHB pipelining (address + data phase separation)**  
- Improve FIFO with **circular buffer design**  
- Add **SystemVerilog assertions for verification**  
- Extend to **AHB-Lite / AXI bridge (future goal)**  

---

## 🛠️ Tools Used

- Verilog HDL  
- GTKWave (waveform analysis)  
- ModelSim / QuestaSim / Vivado  
- EDA Playground  

---

## 💼 Skills Demonstrated

- Verilog RTL Design  
- AMBA AHB Protocol  
- FSM Design  
- FIFO Design  
- Bus Protocol Implementation  
- Debugging using Waveforms  

---

## 💡 Motivation

As an ECE student, I wanted to go beyond theoretical understanding and build a working model of a real industry protocol.

This project helped me realize:
> Hardware design is not just logic — it's timing, synchronization, and protocol correctness.

---

## 👨‍💻 Author

**Raviranjan Kumar**  
B.Tech ECE  
Interested in VLSI, RTL Design, and Embedded Systems  

---

## ⭐ Support

If you find this project useful:
- Star ⭐ the repository  
- Share feedback  
- Suggest improvements  
