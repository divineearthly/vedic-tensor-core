# Vedic Multiplier: Urdhva Tiryagbhyam in Hardware

8×8 recursive Vedic multiplier using the "Vertically and Crosswise" sutra.
Synthesized with Yosys + ABC on ARM64 Termux (OSS CAD Suite).

## Results (8×8, ABC-optimized)
- Vedic: 371 cells, ~2,502 transistors
- Standard: 345 cells, ~2,460 transistors

## Run
```

iverilog -o tb *.v && vvp tb

```

## Synthesize
```

yosys final_compare.ys

```
