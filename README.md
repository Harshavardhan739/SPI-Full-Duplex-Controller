
---

🚀 SPI Full-Duplex Controller Design and Verification using Verilog HDL

> A complete SPI (Serial Peripheral Interface) Full-Duplex Controller designed in Verilog HDL with separate Master and Slave controllers and functional verification using ModelSim Intel FPGA Starter Edition.




---

📖 Overview

> This project presents the RTL design and functional verification of a complete SPI Full-Duplex Controller using Verilog HDL. The design consists of an SPI Master, SPI Slave, Clock Divider, Transmit and Receive Shift Registers, Bit Counter, and FSM-based control logic.



> The SPI Master generates the serial clock and controls the chip-select signal, while the SPI Slave responds to the generated clock and exchanges data simultaneously through MOSI and MISO.



> Functional verification was performed using ModelSim Intel FPGA Starter Edition, demonstrating simultaneous serial transmission and reception between the SPI Master and SPI Slave.



> The implementation validates SPI clock generation, full-duplex data transfer, shift-register operation, bit counting, FSM control, chip-select control, and received-data integrity.




---

🎯 Project Objective

> The objective of this project is to design, implement, and verify a parameterized SPI Full-Duplex Controller using Verilog HDL.



> The project demonstrates synchronous serial communication between an SPI Master and SPI Slave by integrating clock generation, transmit and receive shift registers, bit counting, FSM-based control, and complete end-to-end functional verification.




---

✨ Features

SPI Master Controller

SPI Slave Controller

Full-Duplex Communication

MOSI and MISO Data Transfer

Master-Generated SPI Clock

Chip-Select (CS) Control

Parameterized Data Width

Configurable System Clock Frequency

Configurable SPI Clock Frequency

MSB-First Data Transfer

TX Shift Register

RX Shift Register

Bit Counter

FSM-Based Control Logic

Separate Master and Slave RTL Modules

Modular RTL Architecture

Individual Module Verification

Master-Slave Integration

End-to-End Full-Duplex Verification

ModelSim Waveform Verification

RTL/Dataflow Verification



---

📁 Project Structure

SPI-Full-Duplex-Controller/
│
├── rtl/
│   ├── spi_master.v
│   ├── spi_slave.v
│   ├── clock_divider.v
│   ├── tx_shift_register.v
│   ├── rx_shift_register.v
│   ├── bit_counter.v
│   └── spi_fsm.v
│
├── tb/
│   ├── spi_master_tb.v
│   ├── spi_slave_tb.v
│   └── spi_top_tb.v
│
├── docs/
│   ├── spi_block_diagram.png
│   ├── spi_master_fsm.png
│   ├── spi_slave_fsm.png
│   ├── spi_master_dataflow.png
│   └── spi_slave_dataflow.png
│
├── waveforms/
│   ├── spi_master_waveform.png
│   ├── spi_slave_waveform.png
│   └── spi_full_duplex_waveform.png
│
└── README.md


---

⚙️ Module Description

🧠 SPI Master Controller

The SPI Master controls the SPI communication and generates the serial clock required for data transfer.

Responsibilities

Generates SPI clock (SCLK)

Controls Chip Select (CS)

Transmits data through MOSI

Receives data through MISO

Controls TX/RX shift operations

Maintains the bit-transfer count

Generates busy and done status signals

Controls the overall SPI transfer using FSM logic



---

📤 Master TX Shift Register

The Master TX Shift Register stores the parallel transmit data and shifts the data serially toward the MOSI output.

Features

Parameterized data width

MSB-first transmission

Controlled shift operation

Parallel data loading



---

📥 Master RX Shift Register

The Master RX Shift Register samples serial data received through MISO and reconstructs it into parallel data.

Features

Serial data sampling

Shift-register based reception

Parameterized data width

Parallel received-data output



---

🧠 SPI Slave Controller

The SPI Slave responds to the Master-generated clock and participates in full-duplex communication.

Responsibilities

Responds to CS

Receives data through MOSI

Transmits data through MISO

Performs simultaneous TX/RX shifting

Counts transferred bits

Generates received parallel data



---

📤 Slave TX Shift Register

The Slave TX Shift Register stores the slave transmit data and shifts it toward the MISO output during the SPI transfer.


---

📥 Slave RX Shift Register

The Slave RX Shift Register samples incoming MOSI data and reconstructs the received parallel data.


---

🕐 Clock Divider

The Clock Divider generates the SPI serial clock from the system clock.

Parameters

System Clock Frequency

SPI Clock Frequency


The generated clock is supplied to the SPI Master/Slave communication interface.


---

🔢 Bit Counter

The Bit Counter tracks the number of bits transferred during an SPI transaction.

Functions

Counts transferred bits

Detects completion of a data frame

Supports parameterized data width

Provides transfer-completion information to the control logic



---

🎛️ SPI FSM

The SPI Master control logic uses an FSM to manage the SPI transaction.

FSM States

IDLE

LOAD

TRANSFER

FINISH


State Functions

IDLE

> Waits for a new transfer request.



LOAD

> Loads the transmit data and initializes the transfer.



TRANSFER

> Performs serial data transmission and reception.



FINISH

> Completes the transfer and asserts the appropriate completion status.




---

🔄 SPI Full-Duplex Communication

SPI supports simultaneous transmission and reception.

SPI MASTER
          ┌───────────────┐
          │               │
          │   TX Data     │
          │      │        │
          │      ▼        │
          │ TX Shift Reg  │
          │      │        │
          └──────┼────────┘
                 │
                MOSI
                 │
                 ▼
          ┌───────────────┐
          │   SPI SLAVE   │
          │               │
          │ RX Shift Reg  │
          │      │        │
          │      ▼        │
          │   RX Data     │
          └───────────────┘


          ┌───────────────┐
          │   SPI SLAVE   │
          │               │
          │ TX Shift Reg  │
          │      │        │
          └──────┼────────┘
                 │
                MISO
                 │
                 ▼
          ┌───────────────┐
          │   SPI MASTER  │
          │               │
          │ RX Shift Reg  │
          │      │        │
          │      ▼        │
          │   RX Data     │
          └───────────────┘

       SCLK  ─────────────►
       CS    ─────────────►

> During an SPI transaction, the Master transmits data through MOSI while simultaneously receiving data through MISO, providing full-duplex communication.




---

🏗️ Design Methodology

The SPI Full-Duplex Controller follows a modular and parameterized RTL design methodology.

1. Parameterization of SPI configuration


2. System-clock to SPI-clock generation


3. Transmit shift-register implementation


4. Receive shift-register implementation


5. Bit-counter implementation


6. FSM-based SPI control


7. SPI Master implementation


8. SPI Slave implementation


9. Master-Slave integration


10. Full-duplex communication verification


11. Functional simulation using ModelSim




---

💻 Simulation Environment

HDL Language

Verilog HDL

Simulation Tool

ModelSim Intel FPGA Starter Edition 10.5b

Code Editor

Visual Studio Code

Version Control

GitHub


---

✅ Verification Status

All major modules were verified individually before performing complete Master-Slave integration.

Module	Status

Clock Divider	✅ Verified
Bit Counter	✅ Verified
TX Shift Register	✅ Verified
RX Shift Register	✅ Verified
SPI FSM	✅ Verified
SPI Master	✅ Verified
SPI Slave	✅ Verified
Master-Slave Integration	✅ Verified
Full-Duplex Communication	✅ Passed



---

🧪 Functional Verification

The following functionality has been verified:

SPI Clock Generation

Chip-Select Control

Master Transmission

Master Reception

Slave Transmission

Slave Reception

MOSI Data Transfer

MISO Data Transfer

Full-Duplex Communication

TX Shift Operation

RX Shift Operation

Bit Counting

FSM State Transitions

Busy Signal Operation

Done Signal Assertion

Transfer Completion

Data Integrity

Master-Slave Communication

End-to-End SPI Communication



---

🧪 Test Case

Test Case 1 — Full-Duplex Transfer

Master TX Data : 8'hA5
Slave TX Data  : 8'h3C

Configuration:
    Data Width      : 8-bit
    System Clock    : 100 MHz
    SPI Clock       : 1 MHz
    Bit Order       : MSB First

Expected Result

Master RX Data : 8'h3C
Slave RX Data  : 8'hA5

> Since SPI is a full-duplex protocol, the Master and Slave transmit and receive data simultaneously during the same clock transaction.




---

🎉 Simulation Results

Successful SPI clock generation

Successful Chip-Select control

Successful Master transmission

Successful Slave transmission

Successful Master reception

Successful Slave reception

Correct MOSI communication

Correct MISO communication

Correct TX/RX shifting

Correct bit counting

Correct FSM transitions

Successful full-duplex data transfer

Correct received-data values

Successful Master-Slave communication

No functional errors observed during the verified test cases



---

📊 Results

> The SPI Full-Duplex Controller successfully established synchronous serial communication between the SPI Master and SPI Slave using Verilog HDL. The simulation verified correct SPI clock generation, chip-select control, simultaneous transmission and reception, shift-register operation, bit counting, FSM control, and received-data integrity.



> The final Master-Slave integration demonstrated successful full-duplex communication, where the Master and Slave exchanged data simultaneously through MOSI and MISO.




---

🏗️ SPI Block Diagram




---

🔄 SPI Master FSM




---

🔄 SPI Slave FSM




---

🔧 SPI Master RTL Dataflow




---

🔧 SPI Slave RTL Dataflow




---

📸 Waveforms and RTL Views

📈 SPI Master Waveform




---

📈 SPI Slave Waveform




---

📈 SPI Full-Duplex Waveform




---

🛠️ Skills Demonstrated

Verilog HDL

RTL Design

Parameterized RTL Design

Finite State Machine (FSM)

SPI Communication Protocol

Full-Duplex Communication

Serial Communication

Shift Register Design

Clock Divider Design

Bit Counter Design

Modular Hardware Design

Testbench Development

Functional Verification

Waveform Analysis

ModelSim

GitHub



---

🚀 Future Enhancements

Support for SPI Modes 0–3

Configurable CPOL and CPHA

LSB-First Data Transfer

Multiple Slave Support

Programmable Clock Polarity and Phase

FIFO Buffer Integration

FPGA Hardware Validation

APB/AXI Interface Integration

Interrupt-Based Transfer Completion



---

📚 Learning Outcomes

Through this project, the following concepts were implemented and verified:

RTL Design using Verilog HDL

Parameterized RTL Design

SPI Communication Protocol

Full-Duplex Serial Communication

SPI Master Design

SPI Slave Design

Clock Divider Design

Shift Register Design

Bit Counter Design

FSM Design

Modular Hardware Design

Testbench Development

Functional Simulation

Waveform Analysis

Master-Slave Integration

Data Integrity Verification

RTL/Dataflow Verification



---

👨‍💻 Author

Harshavardhan Akula

GitHub Profile: [GitHub Profile](https://github.com/Harshavardhan739?utm_source=chatgpt.com)


---

📄 License

This project is intended for educational, academic, and learning purposes.


---