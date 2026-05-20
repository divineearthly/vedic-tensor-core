<div align="center">

# ॐ VEDIC TENSOR CORE ॐ

### *Urdhva Tiryagbhyam — Vertically and Crosswise*

**The world's first open-source Vedic mathematics hardware multiplier for AI edge compute.**  
Built on ARM64 Termux. Synthesized with open silicon. Verified against 1,000 random tests.

[![Verilog](https://img.shields.io/badge/Language-Verilog%20RTL-orange?style=flat-square)](https://github.com/divineearthly/vedic-tensor-core)
[![Toolchain](https://img.shields.io/badge/Toolchain-Yosys%20%2B%20Icarus-blue?style=flat-square)](https://github.com/YosysHQ/yosys)
[![Platform](https://img.shields.io/badge/Built%20on-ARM64%20Termux-green?style=flat-square)](https://termux.dev)
[![Tests](https://img.shields.io/badge/Verification-1000%20Tests%20Passed-brightgreen?style=flat-square)](https://github.com/divineearthly/vedic-tensor-core)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)](LICENSE)

---

*A Divine Earthly Initiative — Sovereign Intelligence for All Beings*

</div>

---

## The Problem with Modern AI Compute

Every large language model. Every neural network. Every AI agent running inference.

At their core, they are all doing one thing: **matrix multiplication**.

Modern silicon handles this with Radix-4 Booth encoders and Wallace Tree adders — architectures designed decades ago for generic arithmetic, not for the parallel, recursive nature of tensor operations. As bit-width scales, carry-chain propagation creates deep critical paths that limit clock frequency and increase power.

**AI compute is centralized because edge devices cannot keep up.**

---

## The Ancient Solution

Over 2,500 years ago, Vedic mathematicians encoded a multiplication algorithm into a single sutra:

> **ऊर्ध्वतिर्यग्भ्याम्**
> *Urdhva Tiryagbhyam — Vertically and Crosswise*

This sutra describes a method of generating **all partial products simultaneously** — not sequentially. Every column of partial products is computed in parallel, in a single pass, with no dependency on previous results.

This is not metaphor. This is architecture.

---

## What This Repository Does

This project maps the Urdhva Tiryagbhyam sutra directly into **Verilog RTL** — the language of silicon — creating a hardware multiplier hierarchy verified and synthesized using open-source CMOS tooling:

```
vedic_2x2       →  2-bit × 2-bit  (pure AND/XOR gates, 0 adders)
vedic_mult_4x4  →  4-bit × 4-bit  (4× vedic_2x2, parallel crosswise sums)
vedic_mult_8x8  →  8-bit × 8-bit  (4× vedic_mult_4x4, recursive Urdhva)
```

Each level is a direct hardware expression of the sutra. No shortcuts. No approximations.

---

## Silicon Benchmarks

Synthesized using **Yosys + ABC** targeting standard CMOS gate library on ARM64 Termux (OSS CAD Suite).

### Functional Verification

```
Testing Vedic 8×8 Multiplier
PASS: Max values (255 × 255 = 65025)
PASS: Zero
SUCCESS: All 1000 tests passed!
```

1,000 random 8-bit vectors. Zero failures. Full mathematical parity with hardware `*` operator.

### Area vs Standard Synthesis (8×8)

| Architecture | Cells | ~Transistors |
|---|---|---|
| Vedic (Urdhva Tiryagbhyam) | 371 | ~2,502 |
| Standard (`assign p = a * b`) | 345 | ~2,460 |

The Vedic architecture uses slightly more area in exchange for **flattened adder trees** — the partial products are generated without sequential carry propagation, reducing the critical topological path depth. This is the tradeoff: more gates in parallel vs. fewer gates in series.

> **For AI TPUs and edge inference engines, clock frequency matters more than gate count.**  
> A deeper pipeline at lower frequency loses to a shallower pipeline at higher frequency.

---

## Why This Matters for Edge AI

Centralised AI requires data to travel to a server. For farmers in rural India, for villages without reliable internet, for any human being who deserves intelligence that serves them *where they are* — this model fails.

Sovereign edge AI requires compute at the silicon level to be as efficient as possible. The Vedic multiplier is one piece of that foundation:

- **Lower critical path** → higher possible clock frequency in custom TPU designs
- **Parallel partial products** → natural fit for tensor operation pipelines
- **Fully open source** → reproducible on any ARM64 device with OSS CAD Suite
- **No cloud dependency** → the benchmark runs entirely offline in Termux

This is not a research paper behind a paywall. This is running code you can synthesize on your phone.

---

## Reproduce Everything

### Requirements
```bash
# Install in Termux (ARM64)
pkg install oss-cad-suite
```

### Functional Verification
```bash
iverilog -o tb vedic_2x2.v vedic_mult_4x4_fixed.v vedic_mult_8x8_fixed.v standard_mult.v tb_benchmark.v
vvp tb
```

### Synthesis + Area Report
```bash
yosys final_compare.ys
```

---

## File Structure

| File | Description |
|---|---|
| `vedic_2x2.v` | 2×2 building block — pure AND/XOR, no adders |
| `vedic_mult_4x4_fixed.v` | 4×4 Urdhva Tiryagbhyam — 4 parallel 2×2 blocks |
| `vedic_mult_8x8_fixed.v` | 8×8 recursive — 4 parallel 4×4 blocks |
| `standard_mult.v` | Baseline comparator (`assign p = a * b`) |
| `tb_benchmark.v` | 1000-test verification bench with edge cases |
| `final_compare.ys` | Yosys synthesis script for both architectures |

---

## The Sutra as Code

The beauty of Urdhva Tiryagbhyam is that the algorithm *is* the circuit. There is no translation loss:

```
Sutra:  Generate partial products vertically and crosswise. Sum simultaneously.

RTL:    vedic_2x2 m0 (.a(a[1:0]), .b(b[1:0]), .p(pp0));  // Vertical (LSB)
        vedic_2x2 m1 (.a(a[3:2]), .b(b[1:0]), .p(pp1));  // Crosswise
        vedic_2x2 m2 (.a(a[1:0]), .b(b[3:2]), .p(pp2));  // Crosswise
        vedic_2x2 m3 (.a(a[3:2]), .b(b[3:2]), .p(pp3));  // Vertical (MSB)
        // All four fire simultaneously. No waiting.
```

The ancient and the silicon speak the same language.

---

## Related Projects

This repository is part of the **Divine Earthly** ecosystem of sovereign, open-source AI built on Indian knowledge systems:

- [Divine-Earthly-ASI](https://github.com/divineearthly/Divine-Earthly-ASI) — Offline agricultural AI for rural India
- [Krishi-Veda-Module](https://github.com/divineearthly/Krishi-Veda-Module) — Vedic-grounded crop intelligence engine

---

## Author

**Joydeep Das** — Independent AI Researcher, Silchar, Assam, India  
GitHub: [@divineearthly](https://github.com/divineearthly)

*Built entirely on an Android phone using Termux. No laptop. No lab. No institution.*  
*Just ancient mathematics, open silicon, and the conviction that intelligence should serve everyone.*

---

<div align="center">

**ॐ तत् सत्**  
*That is Truth*

If this work resonates, star the repository and share it.  
The knowledge belongs to everyone.

</div>

