# 5-Stage Pipelined RISC-V Processor

A synthesizable 32-bit RISC-V processor implemented in **Verilog HDL**, developed incrementally from a functional single-cycle architecture toward a **5-stage pipelined processor**.

The project focuses on RTL design, processor datapath and control, instruction execution, simulation-based verification, and eventually pipeline hazard handling and performance-oriented design.

> **Project Status:** 🚧 Under Development
> **Current Stage:** Single-cycle processor modules completed; 5-stage pipeline implementation in progress.

---

## Project Overview

The objective of this project is to design and verify a 32-bit RISC-V processor at the RTL level.

The development is divided into two major stages:

1. **Single-Cycle RISC-V Processor**
2. **5-Stage Pipelined RISC-V Processor**

The completed single-cycle implementation establishes the fundamental processor datapath and control logic. The next phase extends this architecture into a pipelined design with:

* Instruction Fetch (IF)
* Instruction Decode (ID)
* Execute (EX)
* Memory Access (MEM)
* Write Back (WB)
* Data forwarding
* Hazard detection
* Pipeline stalls
* Pipeline flush/control logic
* Verification of dependent and branch instructions

---

## Architecture

### Single-Cycle Processor

The initial processor consists of the following major RTL blocks:

```text
                ┌─────────────────────┐
                │   Program Counter   │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Instruction Memory  │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │   Control Unit      │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │   Register File     │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │        ALU          │
                └──────┬───────┬──────┘
                       │       │
                       │       ▼
                       │  ┌─────────────┐
                       │  │ Data Memory │
                       │  └──────┬──────┘
                       │         │
                       └────┬────┘
                            ▼
                       Write Back
```

### 5-Stage Pipeline

The single-cycle datapath is being extended into the following pipeline:

```text
        ┌────┐    ┌────┐    ┌────┐    ┌─────┐    ┌────┐
        │ IF │ -> │ ID │ -> │ EX │ -> │ MEM │ -> │ WB │
        └────┘    └────┘    └────┘    └─────┘    └────┘
           │         │         │          │          │
           ▼         ▼         ▼          ▼          ▼
          PC      Decode      ALU       Memory     Register
                  RegFile                Access     Write
```

Pipeline registers will be introduced between each stage to allow multiple instructions to be processed concurrently.

---

## Current Progress

### Completed RTL Modules

| Module          | Description                             | Status      |
| --------------- | --------------------------------------- | ----------- |
| `alu.v`         | Arithmetic and logical operations       | ✅ Completed |
| `alu_control.v` | Generates ALU operation control signals | ✅ Completed |
| `main_cu.v`     | Main instruction control unit           | ✅ Completed |
| `regfile.v`     | 32-bit register file                    | ✅ Completed |
| `inst_mem.v`    | Instruction memory                      | ✅ Completed |
| `data_mem.v`    | Data memory                             | ✅ Completed |
| `sign_ext.v`    | Immediate/sign extension logic          | ✅ Completed |

### Verification

Individual RTL modules are being verified using dedicated Verilog testbenches.

Current testbenches include:

```text
alu_tb.v
alu_control_tb.v
main_cu_tb.v
regfile_tb.v
inst_mem_tb.v
data_mem_tb.v
sign_ext_tb.v
```

Simulation waveforms are used to inspect signals and validate the behavior of individual modules.

---

## Development Roadmap

### Phase 1 — RTL Building Blocks

* [x] ALU
* [x] ALU Control
* [x] Main Control Unit
* [x] Register File
* [x] Instruction Memory
* [x] Data Memory
* [x] Immediate/Sign Extension
* [ ] Program Counter
* [ ] Branch/Jump Logic

### Phase 2 — Single-Cycle Processor

* [ ] Integrate datapath
* [ ] Integrate control path
* [ ] Connect instruction fetch and decode
* [ ] Connect register file and ALU
* [ ] Connect data memory
* [ ] Implement write-back path
* [ ] Implement branch and jump handling
* [ ] Complete processor-level testbench
* [ ] Verify multiple RISC-V instructions
* [ ] Verify multiple test programs

### Phase 3 — 5-Stage Pipeline

* [ ] IF stage
* [ ] ID stage
* [ ] EX stage
* [ ] MEM stage
* [ ] WB stage
* [ ] IF/ID pipeline register
* [ ] ID/EX pipeline register
* [ ] EX/MEM pipeline register
* [ ] MEM/WB pipeline register
* [ ] Integrate pipelined datapath
* [ ] Pipeline verification

### Phase 4 — Hazard Handling

* [ ] Identify data hazards
* [ ] Forwarding Unit
* [ ] Hazard Detection Unit
* [ ] Pipeline stall logic
* [ ] Load-use hazard handling
* [ ] Branch hazard handling
* [ ] Pipeline flush logic
* [ ] Verify dependent instructions

### Phase 5 — Verification & Analysis

* [ ] Processor-level testbench
* [ ] Multiple instruction sequences
* [ ] Branch and jump verification
* [ ] Load/store verification
* [ ] Data hazard verification
* [ ] Forwarding verification
* [ ] Stall verification
* [ ] Pipeline waveform analysis
* [ ] Synthesis
* [ ] Area analysis
* [ ] Timing analysis

---

## RISC-V Instruction Support

The processor is being developed around the **32-bit RISC-V ISA**.

The implementation will progressively cover relevant instruction types including:

### R-Type

```text
ADD
SUB
AND
OR
XOR
SLT
```

### I-Type

```text
ADDI
ANDI
ORI
XORI
LW
```

### S-Type

```text
SW
```

### B-Type

```text
BEQ
BNE
```

### U-Type

```text
LUI
AUIPC
```

### J-Type

```text
JAL
```

Instruction support will be expanded and verified as the processor develops.

---

## Repository Structure

The repository is organized to separate RTL design, verification, programs, and documentation.

```text
risc-v-pipelined-processor/
│
├── README.md
│
├── rtl/
│   ├── alu.v
│   ├── alu_control.v
│   ├── main_cu.v
│   ├── regfile.v
│   ├── inst_mem.v
│   ├── data_mem.v
│   ├── sign_ext.v
│   ├── pc.v
│   └── ...
│
├── testbench/
│   ├── alu_tb.v
│   ├── alu_control_tb.v
│   ├── main_cu_tb.v
│   ├── regfile_tb.v
│   ├── inst_mem_tb.v
│   ├── data_mem_tb.v
│   ├── sign_ext_tb.v
│   └── ...
│
├── programs/
│   └── program.hex
│
├── docs/
│   ├── architecture/
│   └── waveforms/
│
└── .gitignore
```

The repository structure will evolve as additional processor stages and verification components are implemented.

---

## Verification Methodology

Verification is performed incrementally.

Each RTL module is first tested independently using a dedicated testbench before being integrated into the processor.

The general verification flow is:

```text
RTL Module
    │
    ▼
Testbench
    │
    ▼
Simulation
    │
    ▼
Waveform Analysis
    │
    ▼
Functional Validation
    │
    ▼
Processor Integration
```

At the processor level, test programs will be used to verify instruction execution and interactions between the datapath and control logic.

Special attention will be given to:

* ALU operations
* Register read/write behavior
* Immediate generation
* Load/store operations
* Branch decisions
* Program counter updates
* Data dependencies
* Pipeline forwarding
* Pipeline stalls
* Pipeline flushes

---

## Tools

The project uses:

* **Verilog HDL** — RTL design
* **Icarus Verilog** — Simulation
* **GTKWave** — Waveform analysis
* **Git/GitHub** — Version control and project tracking

Additional synthesis and timing-analysis tools will be incorporated during later stages of development.

---

## Development Approach

This project is being developed incrementally.

Each major module is:

1. Designed in Verilog HDL
2. Tested using a dedicated testbench
3. Simulated
4. Debugged using waveform analysis
5. Integrated into the processor
6. Verified again at the system level

The GitHub repository is updated continuously as new RTL modules, verification environments, and processor features are completed.

---

## Future Work

The next major development goals are:

1. Complete the remaining single-cycle datapath.
2. Integrate and validate the complete single-cycle processor.
3. Convert the datapath into a 5-stage pipeline.
4. Implement pipeline registers.
5. Implement forwarding logic.
6. Implement hazard detection and stall control.
7. Handle control hazards and pipeline flushing.
8. Perform processor-level verification.
9. Synthesize the design.
10. Analyze area and timing characteristics.
11. Optimize the RTL for improved implementation results.

---

## Project Status

```text
Single-Cycle RTL Modules     ████████████████████  Completed
Single-Cycle Integration     ███████████░░░░░░░░░  In Progress
Single-Cycle Verification    █████████░░░░░░░░░░░  In Progress
5-Stage Pipeline             ███░░░░░░░░░░░░░░░░░  In Progress
Hazard Detection             ░░░░░░░░░░░░░░░░░░░░  Upcoming
Forwarding                   ░░░░░░░░░░░░░░░░░░░░  Upcoming
Stall / Flush Control        ░░░░░░░░░░░░░░░░░░░░  Upcoming
Synthesis & STA              ░░░░░░░░░░░░░░░░░░░░  Upcoming
```

---

## Author

**Harshit Prajesh**

Computer Architecture & VLSI RTL Design Project

---

## License

This project is intended primarily for educational and portfolio purposes.
