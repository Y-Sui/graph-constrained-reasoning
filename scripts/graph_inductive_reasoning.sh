DATA_PATH=rmanluo
# DATA_LIST="RoG-webqsp RoG-cwq"
DATA_LIST="ROG-webqsp"
SPLIT="test"

# MODEL_NAME=gpt-3.5-turbo
# N_THREAD=10
# REASONING_PATH=/ndata/yuansui/graph-constrained-reasoning/results/GenPaths/ROG-webqsp/GCR-Qwen2-0.5B-Instruct/test/zero-shot-group-beam-k10-index_len2

# # MODEL_NAME=gpt-4o-mini
# # N_THREAD=10

# for DATA in ${DATA_LIST}; do
#   REASONING_PATH=${REASONING_PATH}/predictions.jsonl
#   python workflow/predict_final_answer.py \
#     --data_path ${DATA_PATH} \
#     --d ${DATA} \
#     --split ${SPLIT} \
#     --model_name ${MODEL_NAME} \
#     --reasoning_path ${REASONING_PATH} \
#     --add_path True \
#     --use_think True \
#     -n ${N_THREAD}
# done


# MODEL_PATH=/ndata/yuansui/graph-constrained-reasoning/save_models/GCR-Qwen3-0.6B
MODEL_PATH=Qwen/Qwen3-0.6B
MODEL_NAME=$(basename ${MODEL_PATH})
N_THREAD=10
REASONING_PATH=/ndata/yuansui/graph-constrained-reasoning/results/GenPaths/ROG-webqsp/GCR-Qwen2-0.5B-Instruct/test/zero-shot-group-beam-k10-index_len2/predictions.jsonl

for DATA in ${DATA_LIST}; do
  CUDA_VISIBLE_DEVICES=0,1 python workflow/predict_final_answer.py \
    --data_path ${DATA_PATH} \
    --d ${DATA} \
    --split ${SPLIT} \
    --model_name ${MODEL_NAME} \
    --model_path ${MODEL_PATH} \
    --reasoning_path ${REASONING_PATH} \
    --add_path True \
    # --use_think True \
    -n ${N_THREAD} \
    --test True \
done
