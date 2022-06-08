#!/bin/bash
PYTHON='/home/yuho/.conda/envs/CEC/bin/python'
DATASETS=("cifar10" "cifar100" "scars" "herbarium_19" "imagenet_100" "cub" "aircraft")

# Echoing
echo
echo "EXP:      Generalized Category Discovery"
echo "SCRIPT:   extract_features.sh"
echo -n "HOSTNAME: "
hostname
echo -n "ENV:      "
echo ${PYTHON}

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
CKPT="${name}"    # Ex. (28.04.2022_|_27.516)

# GPU setup
echo
echo -n "* Please select GPU ID: "
read -r num
GPU="${num}"
export CUDA_VISIBLE_DEVICES=${GPU}

# Run
cd ../
${PYTHON} -m methods.clustering.extract_features \
  --dataset ${dataset} \
  --use_best_model 'True' \
  --warmup_model_dir "/data01/yuho_hdd/refactored_gcd/metric_learn_gcd/log/${CKPT}/checkpoints/model.pt"
