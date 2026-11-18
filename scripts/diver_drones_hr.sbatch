#!/bin/bash
#SBATCH --job-name=diver-drones-hr
#SBATCH --partition=frida
#SBATCH --gres=gpu:H100:1
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --output=%x_%j.out
source ~/reteco-diver/config.env
$PY ~/reteco-diver/scripts/convert_benchmark.py drones dev
mkdir -p $BASE/diver_data/data/corpus
ln -sfn $DATA/track2_recor/drones/documents.jsonl $BASE/diver_data/data/corpus/drones_documents.jsonl
cd $RECOR
$PY -m experiments.retrieval.ablation_eval \
  --dataset_dir $BASE/diver_data --model_data_dir data --domains drones \
  --model diver-retriever \
  --cache_dir $BASE/diver_cache/hr_dev \
  --output_dir $BASE/diver_results/hr_dev \
  --append-history --append-reasoning
