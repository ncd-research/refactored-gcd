#!/bin/bash
PYTHON='/home/yuho/.conda/envs/CEC/bin/python'
SAVE_DIR='/data01/yuho_hdd/refactored_gcd/results'
DATASETS=("cifar10" "cifar100" "scars" "herbarium_19" "imagenet_100" "cub" "aircraft")

# Echoing
echo
echo "EXP:      Generalized Category Discovery"
echo "SCRIPT:   estimate_k.sh"
echo -n "HOSTNAME: "
hostname
echo -n "ENV:      "
echo ${PYTHON}
echo -n "SAVE_DIR: "
echo ${SAVE_DIR}

# Dataset
echo
echo "* Please select the dataset."
PS3="number: "
select opt in "${DATASETS[@]}"; do
  dataset="${opt}"
  break
done

# GPU setup
echo
echo -n "* Please select GPU ID: "
read -r num
GPU="${num}"
export CUDA_VISIBLE_DEVICES=${GPU}

# Experiment number
EXP_NUM=$(ls ${SAVE_DIR} | wc -l)
EXP_NUM=$((${EXP_NUM} + 1))
echo $EXP_NUM
echo "Experiment number: ${EXP_NUM}"

# Run
if [[ ! -d "${SAVE_DIR}/${dataset}/" ]]
then
    echo "Create ${SAVE_DIR}/${dataset}/ directory."
    mkdir "${SAVE_DIR}/${dataset}/"
fi

cd ../
${PYTHON} -m methods.estimate_k.estimate_k \
  --max_classes 1000 \
  --dataset_name ${dataset} \
  --search_mode other \
  >${SAVE_DIR}/${dataset}/estimate_k_${EXP_NUM}.out
