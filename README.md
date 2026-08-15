🚀 SPI Full-Duplex Controller Design and Verification using Verilog HDL

> A parameterized SPI (Serial Peripheral Interface) Full-Duplex Controller designed in Verilog HDL with Master-Slave communication and functional verification using ModelSim Intel FPGA Starter Edition.




---

📖 Overview

> This project presents the RTL design and functional verification of an SPI Full-Duplex Controller using Verilog HDL.



> The design consists of an SPI Master, SPI Slave, Clock Divider, TX/RX Shift Registers, Bit Counter, and Master FSM-based control logic.



> The SPI Master generates the serial clock and active-low Chip Select signal, while the Master and Slave simultaneously transmit and receive data through the MOSI and MISO signals.



> Functional verification was performed using ModelSim Intel FPGA Starter Edition to validate SPI clock generation, Chip Select control, serial data transmission, serial data reception, FSM operation, and end-to-end full-duplex data integrity.




---

🎯 Project Objective

> The objective of this project is to design, implement, and verify a modular and parameterized SPI Full-Duplex Controller using Verilog HDL.



> The project demonstrates synchronous serial communication between an SPI Master and Slave while validating:



• SPI clock generation  
• Chip Select control  
• Full-duplex data transfer  
• Serial data shifting  
• Data reception  
• Master FSM control  
• Bit counting  
• End-to-end Master-Slave communication


---

✨ Features

• Parameterized SPI Clock Divider  
• Full-Duplex Communication  
• Master and Slave Architecture  
• Configurable Data Width  
• Configurable CPOL  
• SPI Mode 0 Operation  
• Configurable MSB/LSB-First Operation  
• TX/RX Shift Registers  
• Bit Counter  
• Master FSM-Based Control Logic  
• Modular RTL Design  
• Dedicated Master and Slave Testbenches  
• Top-Level System Integration  
• ModelSim Waveform Verification  
• RTL/Dataflow Verification


---

📁 Project Structure

📂 SPI-Full-Duplex-Controller/    
 📂 rtl/ (Design Source Files)    
   📄 spi_master.v    
   📄 spi_slave.v    
   📄 spi_top.v    
   📄 clock_divider.v    
   📄 tx_shift_register.v    
   📄 rx_shift_register.v    
   📄 bit_counter.v    
   📄 spi_fsm.v    
📂 tb/ (Testbench Verification Files)    
   📄 spi_master_tb.v    
   📄 spi_slave_tb.v    
   📄 spi_top_tb.v    
📂 docs/ (Design Documentation and Diagrams)   
   🖼️ spi_block_diagram.png  
   🖼️ spi_master_fsm.png  
   🖼️ spi_master_dataflow.png    
   🖼️ spi_slave_dataflow.png    
📂 waveforms/ (Simulation Waveform Logs)     
   🖼️ spi_master_waveform.png    
   🖼️ spi_slave_waveform.png  
   🖼️ spi_full_duplex_waveform.png  
📄 README.md


---

⚙️ Module Description

🕐 Clock Divider

> The Clock Divider generates the SPI serial clock from the system clock.



Responsibilities:  
• Divides the system clock  
• Generates the required SPI clock timing  
• Controls SCLK generation during an active transfer  
• Supports parameterized system-clock and SPI-clock frequencies


---

📤 SPI Master

> The SPI Master controls and initiates the SPI communication.



Responsibilities:  
• Generates SCLK  
• Controls active-low Chip Select (CS)  
• Transmits data through MOSI  
• Receives data through MISO  
• Controls TX/RX shifting  
• Maintains the transfer bit count  
• Generates busy and done indications  

Master FSM States  

• IDLE    
  ↓ start    
• LOAD    
  ↓    
• TRANSFER    
  ↓ bit_done    
• FINISH    
  ↓    
• IDLE

> The Master FSM controls the SPI transaction sequence from transfer initiation to completion.




---

📥 SPI Slave

> The SPI Slave responds to the Master during an active SPI transaction.



Responsibilities:  
• Monitors active-low Chip Select  
• Receives SCLK from the Master  
• Receives serial data through MOSI  
• Transmits serial data through MISO  
• Performs simultaneous transmission and reception  
• Reconstructs received parallel data  
• Maintains the transfer bit count  
• Generates a transfer completion indication

> The Slave uses CS- and SCLK-controlled sequential logic rather than a separate FSM module.




---

🔄 TX Shift Register

> The TX Shift Register stores parallel transmit data and shifts one bit at a time during SPI communication.



Responsibilities:  
• Parallel data loading  
• Serial bit shifting  
• MSB-first or LSB-first operation  
• Controlled shifting according to SPI timing


---

🔄 RX Shift Register

> The RX Shift Register samples incoming serial data and reconstructs the received parallel data.



Responsibilities:  
• Serial data sampling  
• Bit shifting  
• Parallel data reconstruction  
• MSB-first or LSB-first operation


---

🔢 Bit Counter

> The Bit Counter tracks the number of transferred bits during an SPI transaction.



Responsibilities:  
• Counts transferred bits  
• Detects completion of the SPI frame  
• Generates the bit_done indication  
• Synchronizes transfer progress with the Master FSM


---

🎛️ SPI Top Module

> The SPI Top Module integrates the SPI Master and SPI Slave into a complete full-duplex communication system.



Integration:  
SPI Top  
├── SPI Master  
│   ├── Clock Divider  
│   ├── Master FSM  
│   ├── TX Shift Register  
│   ├── RX Shift Register  
│   └── Bit Counter  
│  
└── SPI Slave  
    ├── TX Shift Logic  
    ├── RX Shift Logic  
    └── Bit Counter / CS-SCLK Control  

SPI Bus Connections:  
• Master MOSI ─────────► Slave MOSI Input  
• Master MISO ◄───────── Slave MISO Output  
• Master SCLK ─────────► Slave SCLK Input  
• Master CS   ─────────► Slave CS Input

> These connections allow the Master and Slave to transmit and receive data simultaneously during the same SPI transaction.




---

🏗️ Design Methodology

> The SPI Full-Duplex Controller follows a modular and parameterized RTL design methodology.



1. Parameterization of SPI data width and clock frequency  
2. SPI clock generation using a clock divider  
3. Parallel transmit-data loading  
4. Serial data transmission  
5. Serial data reception  
6. TX/RX shift-register based data handling  
7. Bit counting  
8. Master FSM-based transaction control  
9. Master-Slave top-level integration  
10. Functional verification using ModelSim


---

💻 Simulation Environment

• HDL Language: Verilog HDL  
• Simulation Tool: ModelSim Intel FPGA Starter Edition 10.5b  
• Code Editor: Visual Studio Code  
• Version Control: GitHub


---

✅ Verification Status

> The design was verified at both module and system levels.



Module / Function           Status  

Clock Divider                  ✅ Verified  
SPI Master                     ✅ Verified  
SPI Slave                      ✅ Verified  
TX Shift Register              ✅ Verified  
RX Shift Register              ✅ Verified  
Bit Counter                    ✅ Verified  
Master FSM                     ✅ Verified  
Top-Level Integration          ✅ Verified  
Full-Duplex Communication      ✅ Passed


---

🧪 Functional Verification

> The following functionality was verified through simulation:



• SPI clock generation  
• Chip Select assertion and de-assertion  
• Master transmission  
• Master reception  
• Slave transmission  
• Slave reception  
• Simultaneous full-duplex data transfer  
• TX shift-register operation  
• RX shift-register operation  
• Bit-counter operation  
• Master FSM state transitions  
• Busy signal operation  
• Done signal operation  
• Received data reconstruction  
• End-to-end Master-Slave communication  
• Data integrity


---

🧪 Test Case

Input Data and Configuration:  
• Master TX Data : 8'hA5 (10100101)  
• Slave TX Data  : 8'h3C (00111100)  
• Data Width     : 8 bits  
• SPI Mode       : Mode 0  
• CPOL           : 0  

Expected Full-Duplex Result:  
• Master RX      : 8'h3C (00111100)  
• Slave RX       : 8'hA5 (10100101)

> During the same SPI transaction, the Master transmits A5 while the Slave transmits 3C. The Master receives 3C and the Slave receives A5, demonstrating full-duplex communication.




---

🎉 Simulation Results

> The simulation results demonstrate:



• Successful SPI Master-Slave communication  
• Correct SPI clock generation  
• Correct Chip Select operation  
• Simultaneous transmission and reception  
• Correct serial data shifting  
• Correct bit counting  
• Correct Master FSM state transitions  
• Correct received data reconstruction  
• Successful full-duplex data exchange  
• Correct transfer completion indication  
• Successful end-to-end system integration


---

📊 Results

> The SPI Full-Duplex Controller successfully demonstrates synchronous serial communication between an SPI Master and Slave.



> The design was verified using ModelSim with simultaneous transmission and reception during the same SPI transaction.



Verified Test Case:  
• Master TX = 8'hA5  
• Slave TX  = 8'h3C  

• Master RX = 8'h3C  
• Slave RX  = 8'hA5

> The exchanged data confirms successful bidirectional full-duplex communication.




---

🏗️ SPI Block Diagram




---

🔄 SPI Master FSM




---

📸 Waveforms and RTL Views

📈 SPI Master Waveform




---

📈 SPI Slave Waveform




---

📈 SPI Full-Duplex Top-Level Waveform




---

🔧 SPI Master RTL Dataflow




---

🔧 SPI Slave RTL Dataflow




---

🛠️ Skills Demonstrated

• Verilog HDL  
• RTL Design  
• Parameterized RTL Design  
• Finite State Machine (FSM)  
• SPI Communication Protocol  
• Full-Duplex Architecture  
• Master-Slave Architecture  
• Shift Register Design  
• Clock Divider Design  
• Bit Counter Design  
• Functional Verification  
• Testbench Development  
• Waveform Analysis  
• RTL/Dataflow Analysis  
• Modular Hardware Design  
• ModelSim  
• GitHub


---

🚀 Future Enhancements

• Support for additional SPI modes  
• Multi-Slave SPI support  
• Dual/Quad SPI support  
• FIFO Buffer Integration  
• APB/AHB Register Interface  
• FPGA Hardware Validation  
• Enhanced error/status reporting


---

📚 Learning Outcomes

> Through this project, the following concepts were implemented and verified:



• RTL Design using Verilog HDL  
• Parameterized RTL Design  
• FSM-Based Hardware Design  
• SPI Communication Protocol  
• SPI Clock Generation  
• Full-Duplex Serial Communication  
• Shift Register Design  
• Bit Counter Design  
• Master-Slave Architecture  
• Modular Hardware Design  
• Functional Simulation  
• Testbench Development  
• Digital System Integration  
• Waveform Analysis  
• RTL/Dataflow Verification  
• ModelSim-Based Verification


---

👨‍💻 Author

A. Harshavardhan
GitHub Profile: https://github.com/Harshavardhan739


---

📄 License

This project is intended for educational, academic, and learning purposes.
Then this ok to upload in readme by removing data flow
