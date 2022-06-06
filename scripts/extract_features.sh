PYTHON='/home/yuho/.conda/envs/CEC/bin/python'

hostname

# GPU setup
echo
echo -n "* Please select GPU ID: "
read -r num
GPU="${num}"
export CUDA_VISIBLE_DEVICES=${GPU}

${PYTHON} -m methods.clustering.extract_features --dataset cifar100 --use_best_model 'True' \
  --warmup_model_dir '/work/sagar/osr_novel_categories/metric_learn_gcd/log/(28.04.2022_|_27.530)/checkpoints/model.pt'
