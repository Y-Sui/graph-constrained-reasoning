DATA_PATH=rmanluo
# DATA_LIST="RoG-webqsp RoG-cwq"
DATA_LIST="ROG-webqsp"
SPLIT="test"
INDEX_LEN=2
ATTN_IMP=flash_attention_2
PROMPT_MODE=zero-shot-think # change from zero-shot, zero-shot-think, and few-shot

# MODEL_PATH=rmanluo/GCR-Meta-Llama-3.1-8B-Instruct
# MODEL_PATH=rmanluo/GCR-Qwen2-0.5B-Instruct
MODEL_PATH=/ndata/yuansui/graph-constrained-reasoning/save_models/GCR-Qwen3-0.6B
# MODEL_PATH=Qwen/Qwen3-0.6B
MODEL_NAME=$(basename "$MODEL_PATH")

K="10" # 3 5 10 20
for DATA in ${DATA_LIST}; do
  for k in $K; do
    CUDA_VISIBLE_DEVICES=0 python workflow/predict_paths_and_answers.py \
      --data_path ${DATA_PATH} \
      --d ${DATA} \
      --split ${SPLIT} \
      --index_path_length ${INDEX_LEN} \
      --model_name ${MODEL_NAME} \
      --model_path ${MODEL_PATH} \
      --k ${k} \
      --n 4 \
      --prompt_mode ${PROMPT_MODE} \
      --generation_mode group-beam \
      --attn_implementation ${ATTN_IMP} \
      --test True \
  done
done
