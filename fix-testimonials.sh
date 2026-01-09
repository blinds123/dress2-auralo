#!/bin/bash
cd "/Users/nelsonchan/Downloads/nanobanana-manual-template copy 2/sections"

# Fix section 18 - testimonials
sed -i '' \
  -e 's/"sequin scratch"/"dress slipping"/g' \
  -e 's/Most sequin items feel like heavy armor/Most strapless dresses feel restrictive/g' \
  -e 's/usually avoid sequins like the plague/usually avoid strapless dresses/g' \
  -e 's/it'"'"'s actually smoother than my regular skirts/it'"'"'s actually more comfortable than my other dresses/g' \
  -e 's/This skirt transformed me/This dress transformed me/g' \
  -e 's/The way the sequins catch/The way the fabric catches/g' \
  -e 's/I'"'"'ve had cheaper strapless dresss/I'"'"'ve had cheaper strapless dresses/g' \
  -e 's/{{BRAND_NAME}} skirt/{{BRAND_NAME}} dress/g' \
  -e 's/and haven'"'"'t lost a single sequin/and it still looks brand new/g' \
  -e 's/The stadjusting, the lining, the leopard print/The construction, the lining, the elegant design/g' \
  -e 's/The leopard pattern is woven so beautifully into the sequins/The elegant design is crafted so beautifully/g' \
  -e 's/This skirt highlights my curves/This dress highlights my curves/g' \
  -e 's/"Silk Lining is a Dream"/"Internal Boning is a Dream"/g' \
  -e 's/"Finally, a Skirt That Breathes"/"Finally, a Dress That Stays Put"/g' \
  -e 's/"Lightweight Sparkle"/"Lightweight Elegance"/g' \
  18-testimonials.html

echo "✅ Section 18 (testimonials) updated"
