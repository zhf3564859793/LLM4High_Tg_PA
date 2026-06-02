#!/bin/bash
set -e

packmol < packmol.inp

gmx editconf \
    -f PA260506_08_bulk_init.pdb \
    -o PA260506_08_bulk_init.gro \
    -box 14.0 14.0 14.0

echo "PA260506_08_bulk_init.gro generated."