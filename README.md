# Vedic Multiplier: Urdhva Tiryagbhyam in Hardware

8x8 recursive multiplier using the ancient Indian "Vertically and Crosswise" sutra.
Synthesized with Yosys + ABC on ARM64 Termux (OSS CAD Suite).

## Results

| Design | Cells | Transistors | Critical Path |
|--------|-------|-------------|---------------|
| Vedic 8x8 | 371 | ~2,502 | **26 gates** |
| Standard 8x8 | 345 | ~2,460 | 36 gates |

**+7.5% area, -28% critical path depth.**

## Run
```bash
iverilog -o tb *.v && vvp tb
yosys -p "synth -top vedic_mult_8x8; abc -g cmos2; ltp"
```
