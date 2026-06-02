#!/bin/bash
set -e

mkdir -p bulk_equil

gmx grompp \
    -f mdp/nvt_900K_200ps.mdp \
    -c bulk_em/em_bulk.gro \
    -p bulk.top \
    -o bulk_equil/nvt_900K_200ps.tpr

gmx mdrun \
    -deffnm bulk_equil/nvt_900K_200ps \
    -v \
    -ntmpi 1 \
    -ntomp 16 \
    -pin on