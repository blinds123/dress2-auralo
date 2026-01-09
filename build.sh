#!/bin/bash
# build.sh v3.0 - Complete template builder
# Handles ALL placeholders in product.config

set -e

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║           LANDING PAGE BUILDER v3.0                        ║"
echo "║           Blank Template → Production Site                 ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# ============================================
# STEP 0: Check Dependencies
# ============================================
echo "🔍 Checking dependencies..."

if ! command -v node &> /dev/null; then
    echo "❌ Node.js not installed. Install from https://nodejs.org"
    exit 1
fi
echo "   ✅ Node.js"

if ! command -v npx &> /dev/null; then
    echo "❌ npx not available"
    exit 1
fi
echo "   ✅ npx"
echo ""

# ============================================
# STEP 1: Load & Validate Config
# ============================================
echo "📝 Loading product.config..."

if [ ! -f "product.config" ]; then
    echo "❌ product.config not found!"
    exit 1
fi

source product.config

# Check required fields
MISSING=""
[ -z "$PRODUCT_NAME" ] && MISSING="$MISSING PRODUCT_NAME"
[ -z "$BRAND_NAME" ] && MISSING="$MISSING BRAND_NAME"
[ -z "$SINGLE_PRICE" ] && MISSING="$MISSING SINGLE_PRICE"
[ -z "$BUNDLE_PRICE" ] && MISSING="$MISSING BUNDLE_PRICE"
[ -z "$NETLIFY_SITE_ID" ] && MISSING="$MISSING NETLIFY_SITE_ID"
[ -z "$GUARANTEE_NAME" ] && MISSING="$MISSING GUARANTEE_NAME"
[ -z "$GUARANTEE_CONDITION" ] && MISSING="$MISSING GUARANTEE_CONDITION"
[ -z "$REVIEW_COUNT" ] && MISSING="$MISSING REVIEW_COUNT"
[ -z "$AUDIENCE" ] && MISSING="$MISSING AUDIENCE"
[ -z "$HEADLINE_HOOK" ] && MISSING="$MISSING HEADLINE_HOOK"
[ -z "$TESTIMONIAL_1" ] && MISSING="$MISSING TESTIMONIAL_1"

if [ -n "$MISSING" ]; then
    echo "❌ Missing required fields in product.config:"
    echo "  $MISSING"
    exit 1
fi

echo "   ✅ Config validated"
echo "   Product: $PRODUCT_NAME"
echo "   Brand: $BRAND_NAME"
echo ""

# ============================================
# STEP 2: Check Images
# ============================================
echo "🖼️  Checking images..."

MISSING_IMAGES=""
for i in 1 2 3 4 5; do
    if [ ! -f "images/product/product-0$i.webp" ] && [ ! -f "images/product/product-0$i.png" ] && [ ! -f "images/product/product-0$i.jpg" ]; then
        MISSING_IMAGES="$MISSING_IMAGES product-0$i"
    fi
done

if [ -n "$MISSING_IMAGES" ]; then
    echo "   ⚠️  Missing product images:$MISSING_IMAGES"
    echo "   Add images to images/product/ folder"
else
    echo "   ✅ Product images found"
fi

# Convert images if cwebp available
if command -v cwebp &> /dev/null; then
    find images -name "*.png" -type f 2>/dev/null | while read file; do
        output="${file%.png}.webp"
        [ ! -f "$output" ] && cwebp -q 80 "$file" -o "$output" 2>/dev/null
    done
    find images -name "*.jpg" -type f 2>/dev/null | while read file; do
        output="${file%.jpg}.webp"
        [ ! -f "$output" ] && cwebp -q 80 "$file" -o "$output" 2>/dev/null
    done
    echo "   ✅ Images optimized"
fi
echo ""

# ============================================
# STEP 3: Build HTML with replacements
# ============================================
echo "📄 Building index.html..."

# Concatenate all sections
cat sections/*.html > index.html

# Detect OS for sed
if [[ "$OSTYPE" == "darwin"* ]]; then
    SED="sed -i ''"
else
    SED="sed -i"
fi

# Function to safely escape for sed
escape_sed() {
    printf '%s\n' "$1" | sed 's/[&/\]/\\&/g'
}

# Replace ALL placeholders
REPLACEMENTS=(
    "{{PRODUCT_NAME}}|$(escape_sed "$PRODUCT_NAME")"
    "{{BRAND_NAME}}|$(escape_sed "$BRAND_NAME")"
    "{{PRODUCT_HANDLE}}|$(escape_sed "$PRODUCT_HANDLE")"
    "{{SUBDOMAIN}}|$(escape_sed "$SUBDOMAIN")"
    "{{SITE_URL}}|$(escape_sed "${SUBDOMAIN}.auralo.store")"
    "{{SINGLE_PRICE}}|$SINGLE_PRICE"
    "{{BUNDLE_PRICE}}|$BUNDLE_PRICE"
    "{{BUNDLE_OLD_PRICE}}|$BUNDLE_OLD_PRICE"
    "{{BUNDLE_SAVINGS}}|$BUNDLE_SAVINGS"
    "{{GUARANTEE_DAYS}}|$GUARANTEE_DAYS"
    "{{GUARANTEE_NAME}}|$(escape_sed "$GUARANTEE_NAME")"
    "{{GUARANTEE_CONDITION}}|$(escape_sed "$GUARANTEE_CONDITION")"
    "{{REVIEW_COUNT}}|$REVIEW_COUNT"
    "{{AUDIENCE}}|$(escape_sed "$AUDIENCE")"
    "{{HEADLINE_HOOK}}|$(escape_sed "$HEADLINE_HOOK")"
    "{{TAGLINE}}|$(escape_sed "$TAGLINE")"
    "{{BEFORE_PAIN}}|$(escape_sed "$BEFORE_PAIN")"
    "{{AFTER_BENEFIT}}|$(escape_sed "$AFTER_BENEFIT")"
    "{{TESTIMONIAL_1}}|$(escape_sed "$TESTIMONIAL_1")"
    "{{TESTIMONIAL_1_NAME}}|$(escape_sed "$TESTIMONIAL_1_NAME")"
    "{{TESTIMONIAL_2}}|$(escape_sed "$TESTIMONIAL_2")"
    "{{TESTIMONIAL_2_NAME}}|$(escape_sed "$TESTIMONIAL_2_NAME")"
    "{{TESTIMONIAL_3}}|$(escape_sed "$TESTIMONIAL_3")"
    "{{TESTIMONIAL_3_NAME}}|$(escape_sed "$TESTIMONIAL_3_NAME")"
    "{{BUNDLE_DESCRIPTION}}|$(escape_sed "$BUNDLE_DESCRIPTION")"
    "{{SINGLE_DESCRIPTION}}|$(escape_sed "$SINGLE_DESCRIPTION")"
)

for pair in "${REPLACEMENTS[@]}"; do
    placeholder="${pair%%|*}"
    value="${pair#*|}"
    if [ -n "$value" ]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' "s|$placeholder|$value|g" index.html 2>/dev/null || true
        else
            sed -i "s|$placeholder|$value|g" index.html 2>/dev/null || true
        fi
    fi
done

# Count remaining placeholders
REMAINING=$(grep -o "{{[^}]*}}" index.html 2>/dev/null | wc -l | tr -d ' ')
echo "   ✅ Built index.html"
if [ "$REMAINING" -gt "0" ]; then
    echo "   ⚠️  $REMAINING placeholders still need values"
    grep -o "{{[^}]*}}" index.html 2>/dev/null | sort -u | head -5
fi
echo ""

# ============================================
# STEP 4: Deploy
# ============================================
echo "🚀 Deploying to Netlify..."

if ! npx netlify status &>/dev/null; then
    echo "   ⚠️  Not logged in to Netlify. Run: npx netlify login"
    echo "   Skipping deployment..."
    PROD_URL="http://localhost:8888"
else
    DEPLOY_OUTPUT=$(npx netlify deploy --prod --site "$NETLIFY_SITE_ID" --dir . 2>&1)
    PROD_URL=$(echo "$DEPLOY_OUTPUT" | grep -o "https://[^[:space:]]*" | head -1)
    echo "   ✅ Deployed"
fi
echo ""

# ============================================
# STEP 5: E2E Tests
# ============================================
echo "🧪 Running Tests..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"

sleep 2

PASS=0
FAIL=0

# Test page loads
HTTP=$(curl -s -o /dev/null -w "%{http_code}" "$PROD_URL" 2>/dev/null || echo "000")
if [ "$HTTP" = "200" ]; then
    echo "   ✅ Page loads"
    ((PASS++))
else
    echo "   ❌ Page failed (HTTP $HTTP)"
    ((FAIL++))
fi

# Test product name appears
PAGE=$(curl -s "$PROD_URL" 2>/dev/null || echo "")
if echo "$PAGE" | grep -q "$PRODUCT_NAME" 2>/dev/null; then
    echo "   ✅ Product name visible"
    ((PASS++))
else
    echo "   ❌ Product name not found"
    ((FAIL++))
fi

# Test no raw placeholders
PLACEHOLDERS=$(echo "$PAGE" | grep -c "{{" || echo "0")
if [ "$PLACEHOLDERS" = "0" ]; then
    echo "   ✅ No raw placeholders"
    ((PASS++))
else
    echo "   ❌ $PLACEHOLDERS raw placeholders visible"
    ((FAIL++))
fi

# Test checkout function
FUNC=$(curl -s -o /dev/null -w "%{http_code}" "$PROD_URL/.netlify/functions/buy-now" 2>/dev/null || echo "000")
if [ "$FUNC" != "404" ]; then
    echo "   ✅ Checkout function exists"
    ((PASS++))
else
    echo "   ❌ Checkout function missing"
    ((FAIL++))
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   Results: $PASS passed, $FAIL failed"
echo ""

# ============================================
# DONE
# ============================================
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                    BUILD COMPLETE                          ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "🌐 Live URL: $PROD_URL"
echo ""
echo "📋 Manual Tests Needed:"
echo "   1. Open on mobile device"
echo "   2. Test Add to Cart"  
echo "   3. Test SimpleSwap checkout"
echo ""
