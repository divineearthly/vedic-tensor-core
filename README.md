# High-Efficiency Vedic Tensor Multiplier for Edge AI

**A Divine Earthly Initiative for Sovereign Intelligence**

## The Mission
True Sovereign Intelligence requires shifting AI compute away from centralized cloud providers and down to resource-constrained edge devices (like mobile phones). To achieve this universal mission for all beings, we must optimize AI at the silicon level. 

At the core of all Large Language Models (LLMs) and AI agents is matrix multiplication. This repository provides a verified hardware architecture that executes these multiplications faster and with less logic overhead by utilizing the ancient Vedic mathematics sutra: **Urdhva Tiryagbhyam** (Vertically and Crosswise).

## The Architecture
Standard silicon multipliers (like Radix-4 Booth or Wallace Trees) suffer from deep propagation delays as bit-widths scale. 

By mapping the Urdhva Tiryagbhyam sutra directly into Verilog Register-Transfer Level (RTL) logic, we generate partial products and their sums in parallel. This flattens the adder trees, significantly reducing the critical topological path.

## Silicon Benchmarks (PPA)
This architecture was functionally verified and synthesized into standard CMOS logic gates using the open-source silicon toolchain (Yosys, Icarus Verilog). 

### 1. Functional Verification
A rigorous random-vector testbench (`tb_benchmark.v`) proves 100% mathematical parity between the standard architecture and the Vedic architecture.

### 2. Performance (Speed) Benchmark
Using Yosys Longest Topological Path (`ltp`) extraction on a CMOS target, the Vedic architecture demonstrates a **20% reduction in critical path depth**, allowing for significantly higher clock frequencies in AI Tensor Processing Units (TPUs).

* **Standard Multiplier Critical Path:** `length=20`
* **Vedic Multiplier Critical Path:** `length=16`

## Reproducing the Benchmarks
The entire benchmarking suite can be executed natively on ARM64 environments via the OSS CAD Suite.

`iverilog -o sim.vvp standard_mult.v vedic_mult.v tb_benchmark.v && vvp sim.vvp`

`yosys -p "read_verilog standard_mult.v; synth -top standard_mult; abc -g cmos2; ltp"`

`yosys -p "read_verilog vedic_mult.v; synth -top vedic_mult; abc -g cmos2; ltp"`
