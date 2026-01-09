#!/bin/bash
cd "/Users/nelsonchan/Downloads/nanobanana-manual-template copy 2"

# Load config
source product.config

# Concatenate all sections
cat sections/*.html > index.html

# Replace placeholders
sed -i '' "s|{{PRODUCT_NAME}}|$PRODUCT_NAME|g" index.html
sed -i '' "s|{{BRAND_NAME}}|$BRAND_NAME|g" index.html
sed -i '' "s|{{PRODUCT_HANDLE}}|$PRODUCT_HANDLE|g" index.html
sed -i '' "s|{{SUBDOMAIN}}|$SUBDOMAIN|g" index.html
sed -i '' "s|{{SITE_URL}}|${SUBDOMAIN}.auralo.store|g" index.html
sed -i '' "s|{{SINGLE_PRICE}}|$SINGLE_PRICE|g" index.html
sed -i '' "s|{{BUNDLE_PRICE}}|$BUNDLE_PRICE|g" index.html
sed -i '' "s|{{BUNDLE_OLD_PRICE}}|$BUNDLE_OLD_PRICE|g" index.html
sed -i '' "s|{{BUNDLE_SAVINGS}}|$BUNDLE_SAVINGS|g" index.html
sed -i '' "s|{{GUARANTEE_DAYS}}|$GUARANTEE_DAYS|g" index.html
sed -i '' "s|{{GUARANTEE_NAME}}|$GUARANTEE_NAME|g" index.html
sed -i '' "s|{{GUARANTEE_CONDITION}}|$GUARANTEE_CONDITION|g" index.html
sed -i '' "s|{{REVIEW_COUNT}}|$REVIEW_COUNT|g" index.html
sed -i '' "s|{{AUDIENCE}}|$AUDIENCE|g" index.html
sed -i '' "s|{{HEADLINE_HOOK}}|$HEADLINE_HOOK|g" index.html
sed -i '' "s|{{TAGLINE}}|$TAGLINE|g" index.html
sed -i '' "s|{{BEFORE_PAIN}}|$BEFORE_PAIN|g" index.html
sed -i '' "s|{{AFTER_BENEFIT}}|$AFTER_BENEFIT|g" index.html
sed -i '' "s|{{TESTIMONIAL_1}}|$TESTIMONIAL_1|g" index.html
sed -i '' "s|{{TESTIMONIAL_1_NAME}}|$TESTIMONIAL_1_NAME|g" index.html
sed -i '' "s|{{TESTIMONIAL_2}}|$TESTIMONIAL_2|g" index.html
sed -i '' "s|{{TESTIMONIAL_2_NAME}}|$TESTIMONIAL_2_NAME|g" index.html
sed -i '' "s|{{TESTIMONIAL_3}}|$TESTIMONIAL_3|g" index.html
sed -i '' "s|{{TESTIMONIAL_3_NAME}}|$TESTIMONIAL_3_NAME|g" index.html
sed -i '' "s|{{BUNDLE_DESCRIPTION}}|$BUNDLE_DESCRIPTION|g" index.html
sed -i '' "s|{{SINGLE_DESCRIPTION}}|$SINGLE_DESCRIPTION|g" index.html

echo "✅ index.html built successfully"
echo "📍 Location: /Users/nelsonchan/Downloads/nanobanana-manual-template copy 2/index.html"
echo ""
echo "Open it in your browser with:"
echo "open index.html"
