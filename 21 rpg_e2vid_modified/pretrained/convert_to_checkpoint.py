import torch

# Load your original weights
state_dict = torch.load("E2F_model.pt", map_location="cpu")

# Load the original checkpoint to get the model config
original_ckpt = torch.load("E2VID_lightweight.pth.tar", map_location="cpu")

# Wrap into a checkpoint with the same structure
checkpoint = {
    'arch': 'E2VIDRecurrent',     # match the original
    'state_dict': state_dict,      # new model weights
    'model': original_ckpt['model']  # copy the model config dictionary
}

# Save as .pth.tar
torch.save(checkpoint, "E2F_model.pth.tar")

print("✅ Converted model saved as E2F_model.pth.tar with correct model config")
