PYTHON='/home/yuho/.conda/envs/CEC/bin/python'

hostname

# GPU setup
echo
echo -n "* Please select GPU ID: "
read -r num
GPU="${num}"
export CUDA_VISIBLE_DEVICES=${GPU}

# Get unique log file
SAVE_DIR=/data01/yuho_hdd/refactored_gcd/results/

EXP_NUM=$(ls ${SAVE_DIR} | wc -l)
EXP_NUM=$((${EXP_NUM} + 1))
echo $EXP_NUM

${PYTHON} -m methods.clustering.k_means --dataset 'scars' --semi_sup 'True' --use_ssb_splits 'True' \
  --use_best_model 'True' --max_kmeans_iter 200 --k_means_init 100 --warmup_model_exp_id '(28.04.2022_|_27.516)' \
  >${SAVE_DIR}logfile_${EXP_NUM}.out
