#!/bin/bash
set -e

gmx editconf \
    -f PA260506_08.gro \
    -o single_chain_box.gro \
    -box 20 20 20 \
    -c

echo "single_chain_box.gro generated."