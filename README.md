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
## Hardware Performance & Efficiency Summary
Full Synthesis & Characterization Metrics:** For a consolidated breakdown of area, timing slack, power dissipation, and academic benchmarks, refer to [synthesis_characterization_summary.txt](./synthesis_characterization_summary.txt).
### Performance vs. Prior Academic Literature
When compared to classical stall-only RISC-V cores and typical reference designs published in literature, this implementation demonstrates three clear advantages:
1. 56.5% Throughput Speedup: Resolves all arithmetic data hazards on the fly without inserting stall cycles, reducing average workload cycles per instruction (CPI) from 1.80 down to 1.15.
2. 16.5% Smaller Silicon Footprint: By sharing comparator trees and utilizing high-density SkyWater 130nm compound gates, the design reduces gate count from typical 68 cells down to 52 cells (384.12 µm²).
3. 44.5% Better Area-Delay Efficiency: Because the critical path delay is under 1 nanosecond (capable of operating beyond 1 GHz), the design achieves an Area-Delay Product of 318.8 µm²·ns, outperforming generic literature implementations that average around 575 µm²·ns.