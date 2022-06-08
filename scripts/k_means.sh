#!/bin/bash
PYTHON='/home/yuho/.conda/envs/CEC/bin/python'
SAVE_DIR='/data01/yuho_hdd/refactored_gcd/results'
DATASETS=("cifar10" "cifar100" "scars" "herbarium_19" "imagenet_100" "cub" "aircraft")

# Echoing
echo
echo "EXP:      Generalized Category Discovery"
echo "SCRIPT:   k_means.sh"
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

# Checkpoints name
echo
echo -n "* Please type the name of checkpoints: "
read -r name
CKPT="${name}"   # Ex. (28.04.2022_|_27.516)

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
${PYTHON} -m methods.clustering.k_means \
  --dataset ${dataset} \
  --semi_sup 'True' \
  --use_ssb_splits 'True' \
  --use_best_model 'True' \
  --max_kmeans_iter 200 \
  --k_means_init 100 \
  --warmup_model_exp_id ${CKPT} \
  >${SAVE_DIR}/${dataset}/k_means_${EXP_NUM}.out
