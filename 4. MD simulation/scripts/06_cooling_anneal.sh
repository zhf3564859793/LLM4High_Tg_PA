#!/bin/bash
set -e

mkdir -p cooling_continuous_clean

gmx grompp \
    -f mdp/cooling_900_to_400_10K_per_ns.mdp \
    -c bulk_equil/npt_900K_30ns.gro \
    -t bulk_equil/npt_900K_30ns.cpt \
    -p bulk.top \
    -o cooling_continuous_clean/cooling_900_to_400.tpr

gmx mdrun \
    -deffnm cooling_continuous_clean/cooling_900_to_400 \
    -v \
    -ntmpi 1 \
    -ntomp 16 \
    -pin on

# gmx mdrun \
#     -deffnm cooling_continuous_clean/cooling_900_to_400 \
#     -cpi cooling_continuous_clean/cooling_900_to_400.cpt \
#     -append \
#     -v \
#     -ntmpi 1 \
#     -ntomp 16 \
#     -pin on