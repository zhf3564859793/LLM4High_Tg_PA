#!/bin/bash
set -e

mkdir -p single_relax

gmx grompp \
    -f mdp/em_single.mdp \
    -c single_chain_box.gro \
    -p single_chain.top \
    -o single_relax/em_single.tpr

gmx mdrun \
    -deffnm single_relax/em_single \
    -v \
    -ntmpi 1 \
    -ntomp 16 \
    -pin on

gmx grompp \
    -f mdp/nvt_single_relax_900K.mdp \
    -c single_relax/em_single.gro \
    -p single_chain.top \
    -o single_relax/nvt_single_relax_900K.tpr

gmx mdrun \
    -deffnm single_relax/nvt_single_relax_900K \
    -v \
    -ntmpi 1 \
    -ntomp 16 \
    -pin on

printf "0\n" | gmx trjconv \
    -f single_relax/nvt_single_relax_900K.xtc \
    -s single_relax/nvt_single_relax_900K.tpr \
    -o single_relax/single_chain_relaxed.gro \
    -dump 100000000

gmx editconf \
    -f single_relax/single_chain_relaxed.gro \
    -o single_relax/single_chain_relaxed.pdb \
    -c

echo "single_chain_relaxed.pdb generated."