import torch

# Since you're already inside the pretrained folder
path = "E2VID_lightweight.pth.tar"

print(f"🔍 Loading checkpoint from: {path}")
checkpoint = torch.load(path, map_location="cpu")

print("\n✅ Type:", type(checkpoint))

if isinstance(checkpoint, dict):
    print("🔑 Keys:", checkpoint.keys())

    # Peek into nested content if present
    if "model_state_dict" in checkpoint:
        print("📂 model_state_dict keys (first 5):", list(checkpoint["model_state_dict"].keys())[:5])
    if "arch" in checkpoint:
        print("🧱 Architecture:", checkpoint["arch"])
else:
    print("📦 Not a dict — it’s a", type(checkpoint))
