#!/bin/bash
set -e

mkdir -p sampled_structures_clean

# temps=(900 875 850 825 800 775 750 725 700 675 650 625 600 575 550 525 500 475 450 425 400)
# times=(0 2500 5000 7500 10000 12500 15000 17500 20000 22500 25000 27500 30000 32500 35000 37500 40000 42500 45000 47500 50000)

temps=(900 850 800 750 700 650 600 550 500 450 400)
times=(0 5000 10000 15000 20000 25000 30000 35000 40000 45000 50000)


for i in "${!temps[@]}"
do
    T=${temps[$i]}
    t=${times[$i]}

    printf "0\n" | gmx trjconv \
        -f cooling_continuous_clean/cooling_900_to_400.xtc \
        -s cooling_continuous_clean/cooling_900_to_400.tpr \
        -o sampled_structures_clean/structure_${T}K.gro \
        -dump ${t}
done