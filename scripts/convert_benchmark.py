import json, os, sys
domain, split = sys.argv[1], sys.argv[2]
base, data = os.environ["BASE"], os.environ["DATA"]
src = f"{data}/track2_recor/{domain}/benchmark_{split}.json"
out_dir = f"{base}/diver_data/data/benchmark"
os.makedirs(out_dir, exist_ok=True)
convs = json.load(open(src, encoding="utf-8"))
with open(f"{out_dir}/{domain}_benchmark.jsonl", "w", encoding="utf-8") as f:
    for c in convs:
        f.write(json.dumps(c, ensure_ascii=False) + "\n")
print(f"wrote {len(convs)} conversations")
