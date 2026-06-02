#!/bin/bash
set -e

mkdir -p bulk_equil

gmx grompp \
    -f mdp/npt_900K_30ns.mdp \
    -c bulk_equil/nvt_900K_200ps.gro \
    -t bulk_equil/nvt_900K_200ps.cpt \
    -p bulk.top \
    -o bulk_equil/npt_900K_30ns.tpr

gmx mdrun \
    -deffnm bulk_equil/npt_900K_30ns \
    -v \
    -ntmpi 1 \
    -ntomp 16 \
    -pin on