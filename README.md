# 📘 UART-Based Data Logger with FIFO and BRAM Integration

This professional-grade project presents a **high-performance UART Data Logger** system implemented using **Verilog HDL**, integrated with **Xilinx Vivado IPs**, and managed via a **MicroBlaze soft processor**. It leverages **FIFO buffering** and **Block RAM (BRAM)** to enable reliable, real-time data logging. Designed with modularity, reliability, and scalability in mind, it is ideal for applications in **industrial automation**, **IoT data capture**, **telemetry systems**, and **sensor-driven embedded platforms**.

---

## 🧱 Project Architecture

### 📂 HDL Components

* `DATA_LOGGER.v`: Top-level Verilog design integrating UART, FIFO, and AXI interfaces.
* `fifo_axi_tb.v`: Comprehensive testbench for functional simulation and timing validation.

### 🖼 Design Visuals

* `DATA_LOGGER_SCHEMATIC.png`: Complete architectural block diagram.
* `LOCAL_MEMORY_BLOCK.png`: Visual of BRAM configuration and interface.
* `AXI_INTERCONNECT_BLOCK.png`: Visualization of AXI data exchange paths.
* `DATA_LOGGER_WRITE_SIMULATION.png`: Depicts UART → FIFO → AXI Write sequence.
* `DATA_LOGGER_READ_SIMULATION.png`: Illustrates FIFO → MicroBlaze → BRAM Read sequence.

---

## 🏗 Functional Description

### 🔧 Core Modules and Descriptions

* **MicroBlaze Processor (`microblaze_0`)**:
  A soft-core processor synthesized on the FPGA to act as the main controller for managing data flow, handling interrupts, and performing memory access operations.

* **AXI UART Lite (`axi_uartlite_0`)**:
  Facilitates asynchronous serial communication between the external host and the FPGA system. It converts incoming serial data into parallel format.

* **FIFO Generator (`fifo_generator_0`)**:
  Temporarily stores incoming UART data and helps manage burst traffic, reducing the risk of data loss during high-speed communication. Triggers an interrupt when a threshold is reached.

* **AXI BRAM Controller (`axi_bram_ctrl_0`)**:
  Provides AXI4-compliant interface logic between the MicroBlaze and the BRAM. It handles low-latency memory reads and writes.

* **Block RAM (`blk_mem_gen_0`)**:
  Serves as persistent on-chip storage to log the data processed by MicroBlaze. Useful for diagnostics, analysis, or later data retrieval.

* **AXI Interrupt Controller (`axi_intc_0`)**:
  Captures interrupt signals from the FIFO and routes them to MicroBlaze. Ensures event-based CPU wake-up for efficient processing.

* **Clocking Wizard (`clk_wiz_1`)**:
  Generates required system clock frequencies and maintains clock domain synchronization across AXI peripherals.

* **Processor System Reset (`proc_sys_reset_0`)**:
  Synchronizes global reset signals, ensuring all modules initialize and function cohesively across asynchronous events.

---

## 🔄 Data Logging Workflow

1. **UART Reception**: Serial data is received through the AXI UART Lite interface.
2. **FIFO Buffering**: The incoming parallelized data is stored in the FIFO buffer.
3. **Interrupt Trigger**: When the FIFO reaches a predefined fill level, it issues an interrupt.
4. **Data Handling**: The interrupt signals the MicroBlaze processor to read data from FIFO and store it in BRAM via AXI BRAM Controller.

This modular pipeline ensures smooth and real-time data capture without dropping bytes even during high-speed transmissions.

---

## 🧪 Verification & Simulation

### ✅ Testbench Verification

* Simulates UART data traffic with variable baud rates.
* Injects random bursts and delays to test buffer overflow/underflow scenarios.
* Validates the responsiveness of the interrupt-driven mechanism.
* Ensures BRAM memory locations are correctly updated and readable.

### 📈 Timing Waveforms

* **Write Cycle**: `DATA_LOGGER_WRITE_SIMULATION.png` confirms successful UART → FIFO → AXI write operations.
* **Read Cycle**: `DATA_LOGGER_READ_SIMULATION.png` confirms proper FIFO → MicroBlaze → BRAM data capture.

---

## 🚀 Deployment Guide

### ⚙ Requirements

* [Vivado Design Suite](https://www.xilinx.com/products/design-tools/vivado.html)
* [Xilinx Vitis / SDK](https://www.xilinx.com/products/design-tools/vitis.html)
* UART Terminal Tool (PuTTY, Tera Term, or Minicom)

### 📦 Project Setup

```bash
git clone https://github.com/yourusername/uart_data_logger.git
cd uart_data_logger
```

#### 1. Open Vivado Project

* Launch Vivado.
* Run synthesis, implementation, and generate the bitstream.

#### 2. Firmware Development

* Open Vitis/SDK.
* Import hardware platform from Vivado.
* Develop C application that reads from FIFO and logs data into BRAM.

#### 3. Testing

* Program FPGA with generated bitstream.
* Use UART terminal to send test data.
* Confirm successful BRAM logging through memory inspection or read-back.

---

## 🧠 Design Highlights

* 📌 **Interrupt-Driven Efficiency**: Reduces processor overhead by responding only to meaningful events.
* 📌 **Dual-Stage Buffering**: FIFO prevents data loss during UART bursts; BRAM ensures persistent storage.
* 📌 **AXI Protocol Compliance**: Enables modular interfacing and scalability.
* 📌 **Future-Proof**: Easily extendable to add DMA, SD card storage, or Ethernet transmission.

---

## 🧩 Integration Map (MicroBlaze System)

| Module               | Instance Name      | Function                       |
| -------------------- | ------------------ | ------------------------------ |
| MicroBlaze           | `microblaze_0`     | Embedded soft-core processor   |
| UART Lite            | `axi_uartlite_0`   | Serial input interface         |
| FIFO Generator       | `fifo_generator_0` | Handles burst data temporarily |
| AXI BRAM Controller  | `axi_bram_ctrl_0`  | BRAM access protocol logic     |
| BRAM                 | `blk_mem_gen_0`    | Non-volatile data storage      |
| Interrupt Controller | `axi_intc_0`       | Routes interrupt signals       |
| Clock Wizard         | `clk_wiz_1`        | Clock signal generator         |
| Reset Logic          | `proc_sys_reset_0` | Manages system resets          |

---

## 🖼 Visual Documentation

| Image                              | Purpose                                                |
| ---------------------------------- | ------------------------------------------------------ |
| `DATA_LOGGER_SCHEMATIC.png`        | Hierarchical overview of the entire data logger system |
| `LOCAL_MEMORY_BLOCK.png`           | Depiction of BRAM and its controller setup             |
| `AXI_INTERCONNECT_BLOCK.png`       | AXI bus and data flow visualization                    |
| `DATA_LOGGER_WRITE_SIMULATION.png` | Write path validation during UART transfer             |
| `DATA_LOGGER_READ_SIMULATION.png`  | Confirming data retrieval from BRAM                    |

---

## 📁 File Directory Structure

```
├── README.md               # Project overview and instructions
├── DATA_LOGGER.v           # Top-level HDL module
├── fifo_axi_tb.v           # Testbench for simulation
└── *.png                   # Visual documentation    
```

## 🙌 Acknowledgments

Gratitude to:

* Xilinx Documentation & Forums
* Open-source AXI/IP developers
* Mentors and collaborators for continuous guidance

---

## 🤝 Contributions

* Submit Issues [🔗](https://github.com/yourusername/uart_data_logger/issues)
* Submit Pull Requests [🔗](https://github.com/yourusername/uart_data_logger/pulls)
* ⭐ Star the repository if it helped you!

> *“From bits to BRAM – enabling smart data capture, byte by byte.”*
