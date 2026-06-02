#!/bin/bash
set -e

mkdir -p bulk_em

gmx grompp \
    -f mdp/em_bulk.mdp \
    -c PA260506_08_bulk_init.gro \
    -p bulk.top \
    -o bulk_em/em_bulk.tpr

gmx mdrun \
    -deffnm bulk_em/em_bulk \
    -v \
    -ntmpi 1 \
    -ntomp 16 \
    -pin on