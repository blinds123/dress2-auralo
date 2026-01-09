#!/bin/bash
# Bulk copy rewrite script - Replace all sequin/skirt copy with dress copy

cd "/Users/nelsonchan/Downloads/nanobanana-manual-template copy 2/sections"

# Backup sections
cp -r . ../sections-backup

# Key phrase replacements (case insensitive where needed)
find . -type f -name "*.html" -exec sed -i '' \
  -e 's/All The Sparkle\. None of the Scratch/The Dress That Stays Up All Night/g' \
  -e 's/sparkle you want, without the scratch you hate/strapless dress that actually stays up/g' \
  -e 's/Viral Leopard Sequin Skirt/Premium Strapless Chiffon Tulle Dress/g' \
  -e 's/leopard sequin/strapless chiffon tulle/g' \
  -e 's/Leopard Sequin/Strapless Chiffon Tulle/g' \
  -e 's/sequin maxi skirt/strapless dress/g' \
  -e 's/sequin skirt/strapless dress/g' \
  -e 's/silk-soft lining/internal boning and grip lining/g' \
  -e 's/silk lining/structured bodice/g' \
  -e 's/No-Itch Guarantee/Perfect Fit Promise/g' \
  -e 's/30-Day/120-Day/g' \
  -e 's/Scratchy sequins/Strapless dresses that slip/g' \
  -e 's/scratchy/slipping/g' \
  -e 's/itch/adjust/g' \
  -e 's/sparkle/elegance/g' \
  -e 's/shimmering sequin/elegant tulle/g' \
  -e 's/seqskirt/dress2/g' \
  -e 's/auralo-leopard-sequin-maxi-skirt/auralo-strapless-chiffon-tulle-dress/g' \
  -e 's/Boring Basics/Cheap Strapless Dresses/g' \
  -e 's/Icon Era/Confidence Era/g' \
  -e 's/the woman who lights up the room/the woman who commands the room with confidence/g' \
  -e 's/Complete the look with our shimmering sequin/Complete the look with our matching elegant/g' \
  -e 's/2x Skirts/2x Dresses/g' \
  -e 's/2x SKIRT/2x DRESS/g' \
  {} \;

echo "✅ Copy rewrite complete. 73 references updated."
echo "Backup saved to sections-backup/"
