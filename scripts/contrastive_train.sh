PYTHON='/home/yuho/.conda/envs/CEC/bin/python'

hostname

# GPU setup
echo
echo -n "* Please select GPU ID: "
read -r num
GPU="${num}"
export CUDA_VISIBLE_DEVICES=${GPU}

# Get unique log file,
SAVE_DIR=/data01/yuho_hdd/refactored_gcd/results/

EXP_NUM=$(ls ${SAVE_DIR} | wc -l)
EXP_NUM=$((${EXP_NUM} + 1))
echo $EXP_NUM

${PYTHON} -m methods.contrastive_training.contrastive_training \
  --dataset_name 'scars' \
  --batch_size 128 \
  --grad_from_block 11 \
  --epochs 200 \
  --base_model vit_dino \
  --num_workers 16 \
  --use_ssb_splits 'True' \
  --sup_con_weight 0.35 \
  --weight_decay 5e-5 \
  --contrast_unlabel_only 'False' \
  --transform 'imagenet' \
  --lr 0.1 \
  --eval_funcs 'v1' 'v2' \
  >${SAVE_DIR}logfile_${EXP_NUM}.out
