#!/bin/bash
#SBATCH --job-name=build-env
#SBATCH --partition=frida
#SBATCH --gres=gpu:H100:1
#SBATCH --time=00:45:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --output=%x_%j.out
source ~/reteco-diver/config.env
ENV=$BASE/envs/diver_env312
rm -rf $ENV
/usr/bin/python3.12 -m venv --copies $ENV
$PY -m pip install --upgrade pip
$PY -m pip install "vllm>=0.8.5" "transformers>=4.51.0" "sentence-transformers>=2.7.0" torch pytrec_eval tqdm numpy pandas torchmetrics tiktoken openai cohere voyageai gritlm InstructorEmbedding
$PY -c "import vllm, torch, cohere; print('vllm', vllm.__version__, 'torch', torch.__version__, 'cuda', torch.cuda.is_available())"
