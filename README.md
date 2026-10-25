# riscv-hazard-verification
RTL design and verification of hazard detection and forwarding logic for a 5-stage RISC-V pipeline.

## Project Progress
- [x] Day 1: Register Pipeline Stage Implementation
- [x] Day 2: ID/EX Register Unit
- [x] Day 3: Hazard Detection Unit Logic
- [x] Day 4: Forwarding Unit Logic
- [x] Day 5: Hazard Detection Unit Verification
- [x] Day 6: Forwarding Unit Verification
- [x] Day 7: Full System Integration & Simulation Setup
- [x] Day 8: Simulation Execution & Verification
- [x] Day 9: GTKWave Timing Diagram Verification
- [x] Day 10: Final Documentation and Repository clean up
![Simulation Waveform](waveform.png)
## Hardware Synthesis & Sky130 Results
Both units were synthesized with Yosys using the open-source SkyWater 130nm standard cell library (`sky130_fd_sc_hd`) at a standard operating condition of 1.8V and a 100 MHz clock frequency.
### Overview
Both modules consist entirely of combinational logic, meaning neither requires flip-flops or clock cycles of their own. Together, the complete hazard management subsystem takes up roughly 384 µm² of silicon area and consumes about 52 µW of total power.
Forwarding Unit Takes 34 standard cells and covers an area of 252.74 µm². Because it actively compares register addresses across pipeline stages to steer operands on the fly, it consumes approximately 33.73 µW
Hazard Detection Unit: A much lighter design taking only 18 standard cells with an area of 131.38 µm². It monitors for load-use delays and branches, drawing roughly 17.85 µW.
### Summary Table
| Module        |StandardCells|SiliconArea(µm²)|TotalPower(µW)|
|ForwardingUnit|   34         |      252.74    |    ~33.73    |
|HazardDetectionUnit|    18   |      131.38    |    ~17.85    |
|TotalSubsystem|      52      |      384.12    |    ~51.58    |