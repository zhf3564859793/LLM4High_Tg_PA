#!/bin/bash
set -e

#temps=(900 875 850 825 800 775 750 725 700 675 650 625 600 575 550 525 500 475 450 425 400)
temps=(900 850 800 750 700 650 600 550 500 450 400)

mkdir -p sampled_npt_clean_r1
mkdir -p analysis

summary_file="analysis/density_summary_after_each_point.csv"
echo "Temperature_K,MeanDensity_last10pct_kg_m3" > "${summary_file}"

for T in "${temps[@]}"
do
    workdir="sampled_npt_clean_r1/T${T}"
    mkdir -p "${workdir}"

    sed "s/REF_TEMP/${T}/g" mdp/npt_5ns_template.mdp > "${workdir}/npt_${T}.mdp"

    gmx grompp \
        -f "${workdir}/npt_${T}.mdp" \
        -c "sampled_structures_clean/structure_${T}K.gro" \
        -p bulk.top \
        -o "${workdir}/npt_${T}.tpr"

    gmx mdrun \
        -deffnm "${workdir}/npt_${T}" \
        -v \
        -ntmpi 1 \
        -ntomp 16 \
        -pin on

    printf "21\n0\n" | gmx energy \
        -f "${workdir}/npt_${T}.edr" \
        -o "${workdir}/density_${T}.xvg"

    mean_density=$(awk '
        !/^[@#]/ {print $1, $2}
    ' "${workdir}/density_${T}.xvg" | awk '
        {time[NR]=$1; dens[NR]=$2}
        END{
            start=int(NR*0.9)
            if (start < 1) start=1
            sum=0; n=0
            for(i=start; i<=NR; i++){
                sum += dens[i]
                n++
            }
            if(n>0) printf "%.6f", sum/n
        }
    ')

    echo "${T},${mean_density}" >> "${summary_file}"
    echo "Finished T=${T} K, mean density (last 10%) = ${mean_density} kg/m^3"
done