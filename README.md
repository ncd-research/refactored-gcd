# Generalized Category Discovery

- This repo is based on [sgvaze/generalized-category-discovery](https://github.com/sgvaze/generalized-category-discovery)
- The code has been refactored for personal research purpose.


## Notice

The author introduced a more rigorous evaluation metric - when computing ACC, they compute the Hungarian algorithm only once across all unlabelled data.

- This single set of linear assignments is then used to compute ACC on 'Old' and 'New' class subsets (see Appendix E)
- Practically, this involves switching from 'v1' to 'v2' evaluation in ```./utils/cluster_and_log_utils.py```


## Config

- Set paths to datasets, pre-trained models and desired log directories in ```config.py```
- Set ```SAVE_DIR``` (logfile destination) and ```PYTHON``` (path to python interpreter) in ```scripts``` scripts.

## Dataset

- Fine-grained benchmarks in this paper, including [The Semantic Shift Benchmark (SSB)](https://github.com/sgvaze/osr_closed_set_all_you_need#ssb) and [Herbarium19](https://www.kaggle.com/c/herbarium-2019-fgvc6)
- Generic object recognition datasets, including [CIFAR-10/100](https://pytorch.org/vision/stable/datasets.html) and [ImageNet](https://image-net.org/download.php)


## Scripts

Train representation

```
bash scripts/contrastive_train.sh
```

Extract features to prepare for semi-supervised k-means. It will require changing the path for the model with which to extract features in ```warmup_model_dir```

```
bash scripts/extract_features.sh
```

Fit semi-supervised k-means

```
bash scripts/k_means.sh
```

- Under the old evaluation metric ('v1') they found that semi-supervised k-means consistently boosted performance over standard k-means, on 'Old' and 'New' data subsets. 
- When they changed to 'v2' evaluation, they re-evaluated models in Tables {2,3,5} (including the ablation) and updated the figures.
- However, recently, SS-k-means can be sensitive to bad initialisation under 'v2', and can sometimes *lower* performance on *some* datasets. Increasing the number of inits for SS-k-means can help.

## Results

- 결과가 논문과 너무 차이나기 때문에 코드 하나하나 자세히 살펴볼 필요가 있음

| **v2 accuracies**             | **All** | **Old** | **New** |
|-------------------------------|---------|---------|---------|
| Stanford Cars (paper)         | 39.0    | 57.6    | 29.9    |
| Stanford Cars (original repo) | 39.9    | 58.5    | 30.9    |
| Stanford Cars (reproduce)     | 41.0    | 61.8    | 31.0    |
| CIFAR100 (paper)              | 70.8    | 77.6    | 57.0    |
| CIFAR100 (original repo)      | 71.3    | 77.4    | 59.1    |
| CIFAR100 (reproduce)          | 74.1    | 80.3    | 61.6    |
