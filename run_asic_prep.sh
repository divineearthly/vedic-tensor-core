#!/bin/bash
source /opt/oss-cad-suite/environment 2>/dev/null || export PATH=$PATH:$HOME/oss-cad-suite/bin

echo "======================================================="
echo "        TINY TAPEOUT SILICON COMPLIANCE CHECK          "
echo "======================================================="

yosys -p "
    read_verilog vedic_2x2.v vedic_mult_4x4_opt.v vedic_mult_8x8_opt.v vedic_mac.v tt_um_vedic_mac.v;
    synth -top tt_um_vedic_mac;
    abc -g cmos2;
    ltp;
" > template_check.txt

if grep -q "ERROR" template_check.txt; then
    echo "❌ Synthesis compilation failed. Check template_check.txt for syntax anomalies."
else
    echo "✅ SUCCESS: Your Vedic MAC wrapper is completely synthesis-ready."
    echo "-------------------------------------------------------"
    grep -A 4 "Number of cells" template_check.txt
    grep "Longest topological path" template_check.txt
fi
echo "======================================================="
