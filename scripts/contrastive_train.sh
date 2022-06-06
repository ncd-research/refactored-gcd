#!/bin/bash
PYTHON='/home/yuho/.conda/envs/CEC/bin/python'
SAVE_DIR='/data01/yuho_hdd/refactored_gcd/results'
DATASETS=("cifar10" "cifar100" "scars" "herbarium_19" "imagenet_100" "cub" "aircraft")

# Echoing
echo
echo "EXP:      Generalized Category Discovery"
echo "SCRIPT:   contrastive_train.sh"
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
echo "Experiment number: ${EXP_NUM}"

# Run
if [[ ! -d "${SAVE_DIR}/${dataset}/" ]]
then
    echo "Create ${SAVE_DIR}/${dataset}/ directory."
    mkdir "${SAVE_DIR}/${dataset}/"
fi

cd ../
${PYTHON} -m methods.contrastive_training.contrastive_training \
  --dataset_name ${dataset} \
  --batch_size 128 \
  --grad_from_block 11 \
  --epochs 200 \
  --base_model vit_dino \
  --num_workers 16 \
  --use_ssb_splits 'True' \
  --sup_con_weight 0.35 \
  --weight_decay 5e-5 \
  --contrast_unlabel_only 'False' \
  --transform "imagenet" \
  --lr 0.1 \
  --eval_funcs 'v1' 'v2' \
  >${SAVE_DIR}/${dataset}/contrastive_train_${EXP_NUM}.out
