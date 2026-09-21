import cv2
import numpy as np
import os
from datetime import datetime

# --- Ask user for input directory ---
input_dir = input("Enter the path to the input image folder: ").strip()

print("Lower values give more sensitivity")
print("Min: -1.3 | default:1.6 | Max:???")
add_multipliers = float(input("Enter sensitivity (default=1.6): ").strip())

print("BLUR")
print("Kernel size has to be odd. Default = 5. Higher value gives more blur.")
print("Sigma = 0 makes OpenCV calculate it automatically. Higher Sigma (1 to 2) gives more blur.")
blur_ksize = int(input("KERNEL SIZE: ").strip())
blur_sigma = float(input("SIGMA: ").strip())

#input_dir = "en_bild"

# Validate input directory
if not os.path.isdir(input_dir):
    print(f"❌ Error: '{input_dir}' is not a valid directory.")
    exit(1)

# --- Create timestamped output directory ---
timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")

output_dir = f"{input_dir}_canny_sensitivity={add_multipliers}_kernel={blur_ksize}_sigma={blur_sigma}_{timestamp}"

#output_dir = f"output"

os.makedirs(output_dir, exist_ok=True)

print(f"📂 Input directory:  {input_dir}")
print(f"📁 Output directory: {output_dir}\n")

# --- Gaussian blur kernel size ---
#blur_ksize = 5  # odd number

# --- Process each frame ---
for idx, filename in enumerate(sorted(os.listdir(input_dir))):
    if not filename.lower().endswith(('.png', '.jpg', '.jpeg')):
        continue

    img_path = os.path.join(input_dir, filename)
    frame = cv2.imread(img_path)
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Step 1: Reduce noise
    blurred = cv2.GaussianBlur(gray, (blur_ksize, blur_ksize), blur_sigma)

    # Step 2: Compute Sobel gradients
    grad_x = cv2.Sobel(blurred, cv2.CV_64F, 1, 0, ksize=3)
    grad_y = cv2.Sobel(blurred, cv2.CV_64F, 0, 1, ksize=3)
    grad_mag = cv2.magnitude(grad_x, grad_y)

    # Step 3: Compute median gradient magnitude
    med = np.median(grad_mag)

    # Step 4: Set Canny thresholds based on median
    #Lower the multipliers in middle to get more sensitive detection.
    #add_multipliers = 1.6 
    low_thresh = max(0, (1.3+add_multipliers) * med)
    high_thresh = min(255, (2.3+add_multipliers) * med)

    # Step 5: Detect edges using Canny
    edges = cv2.Canny(blurred, low_thresh, high_thresh)

    # Step 6: Save result
    out_path = os.path.join(output_dir, f"frame_{idx:04d}.png")
    cv2.imwrite(out_path, edges)

    print(f"Processed {filename} → {out_path} (low={low_thresh:.1f}, high={high_thresh:.1f})")

print(f"\n✅ All frames processed and saved in: {output_dir}")
