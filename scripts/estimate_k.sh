PYTHON='/home/yuho/.conda/envs/CEC/bin/python'

hostname

# Get unique log file
SAVE_DIR=/data01/yuho_hdd/refactored_gcd/results/

EXP_NUM=$(ls ${SAVE_DIR} | wc -l)
EXP_NUM=$((${EXP_NUM} + 1))
echo $EXP_NUM

${PYTHON} -m methods.estimate_k.estimate_k --max_classes 1000 --dataset_name herbarium_19 --search_mode other \
  >${SAVE_DIR}logfile_${EXP_NUM}.out