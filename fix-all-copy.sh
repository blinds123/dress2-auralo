#!/bin/bash
# Comprehensive fix script for ALL remaining old copy

cd "/Users/nelsonchan/Downloads/nanobanana-manual-template copy 2/sections"

# Fix section 08 - multirow
sed -i '' \
  -e 's/Imagine: Dancing All Night (Without the Itch)/Dance All Night With Zero Adjustments/g' \
  -e 's/The lights hit the sequins, and you'"'"'re glowing/You walk in wearing confidence/g' \
  -e 's/sequin scratch/dress slipping/g' \
  -e 's/Our premium internal boning and grip lining feels like a second skin/Internal boning keeps it secure all night/g' \
  -e 's/your {{BRAND_NAME}} skirt/your {{BRAND_NAME}} dress/g' \
  -e 's/buying a skirt/buying a dress/g' \
  08-multirow.html

# Fix section 09 - slideshow
sed -i '' \
  -e 's/viral Strapless Chiffon Tulle Maxi Skirt that broke the internet/strapless dress that actually stays up/g' \
  -e 's/silk-soft/double-lined premium tulle/g' \
  09-slideshow.html

# Fix section 11 - image-with-text-1
sed -i '' \
  -e 's/sequins but hated the constant adjusting/strapless dresses but hated constant pulling and adjusting/g' \
  -e 's/Strapless Chiffon Tulle Maxi Skirt/Strapless Chiffon Tulle Dress/g' \
  11-image-with-text-1.html

# Fix section 12 - image-with-text-2
sed -i '' \
  -e 's/The Secret to "No-Itch" Sparkle/The Secret to Stay-Put Security/g' \
  -e 's/strapless dresss use a cheap, single-layer construction that leaves raw edges scratching your skin/strapless dresses slip down because they lack proper internal structure/g' \
  -e 's/Multi-Layer Mechanism/Internal Boning System/g' \
  -e 's/high-density sequin outer shell fused with/premium double-lined tulle with structured/g' \
  -e 's/Strapless Chiffon Tulle Skirt/Strapless Chiffon Tulle Dress/g' \
  -e 's/elegance/staying power/g' \
  12-image-with-text-2.html

# Fix section 13 - image-with-text-3
sed -i '' \
  -e 's/this skirt is your ticket/this dress is your ticket/g' \
  -e 's/high-density sequins with a signature internal boning/double-lined tulle with internal boning/g' \
  13-image-with-text-3.html

# Fix section 14 - FAQ
sed -i '' \
  -e 's/{{BRAND_NAME}} skirt/{{BRAND_NAME}} dress/g' \
  -e 's/skirt with an ultra-soft/dress with double-lined/g' \
  -e 's/even a single scratch/it slips down even once/g' \
  -e 's/Will the sequins fall off easily/Will the tulle snag or tear easily/g' \
  -e 's/high-density lockdown stadjust for every single sequin/premium tulle construction with reinforced seams/g' \
  -e 's/"No-Itch" money-back/"Stays Up" money-back/g' \
  14-faq.html

echo "✅ All sections updated with dress-specific copy"
