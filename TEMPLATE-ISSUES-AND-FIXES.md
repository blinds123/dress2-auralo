# Template Issues & Fixes Documentation

**Created:** 2026-01-09
**Project:** Nanobanana Manual Landing Page Template
**Purpose:** Document all issues encountered during dress2.auralo.store deployment for future template improvements

---

## 🚨 Critical Issues Found

### 1. **Phase 4 Copy Rewrite Not Automated**

**Issue:** Template contained 73+ instances of old product copy (Leopard Sequin Skirt) that weren't automatically replaced by the build script.

**Impact:** High - Required manual bulk find/replace script, still left 32 references

**Root Cause:** Build script only replaces {{PLACEHOLDER}} variables, doesn't rewrite actual sales copy in HTML sections

**Fix Applied:**

- Created `rewrite-copy.sh` script with 35+ sed replacements
- Manually updated rotating testimonials
- Updated feature cards text

**Future Solution:**

- Add Phase 4 automation that uses AI/LLM to rewrite ALL sales copy based on buyer research
- Replace hardcoded copy blocks with template variables
- Create copy-generation script that reads BUYER-RESEARCH.md and generates contextual copy

---

### 2. **Carousel/Slider JavaScript Missing**

**Issue:** Product image carousel slider buttons don't function - no JavaScript loaded

**Impact:** High - Users cannot navigate through product images

**Root Cause:** `scripts/scripts.js` file doesn't exist, referenced in sections/01-head.html line 75

**Fix Applied:** None yet - issue discovered at end

**Future Solution:**

- Include scripts.js file with slider-component, media-gallery custom elements
- Or use vanilla JS carousel implementation
- Test carousel functionality in build validation phase

---

### 3. **Duplicate UI Elements**

**Issue:** Two "Add to Cart" buttons displayed (mobile ATC + product form button)

**Impact:** Medium - Confusing UX, incorrect button should be removed

**Fix Applied:** Removed duplicate bottom button (lines 1101-1164 of 05-main-product.html)

**Future Solution:**

- Template should have single ATC button with responsive positioning
- Add build validation to check for duplicate buttons/forms

---

### 4. **Order Bump Checkbox Not Pre-checked**

**Issue:** Order bump checkbox wasn't checked by default despite being "pre-checked" offer

**Impact:** Medium - Lower conversion rate on order bump

**Fix Applied:** Added `checked` attribute to checkbox at line 829

**Future Solution:**

- Template config should specify: `ORDER_BUMP_PRECHECKED=true/false`
- Build script auto-adds `checked` attribute based on config

---

### 5. **Misplaced Comparison Image**

**Issue:** Standalone comparison image (comparison-new.webp) displayed in main product section when dedicated comparison slider section already exists

**Impact:** Medium - Redundant, breaks page flow

**Fix Applied:** Removed lines 564-569 from 05-main-product.html

**Future Solution:**

- Remove hardcoded comparison image block from template
- Only use comparison slider section (section 06)

---

### 6. **Size Chart Button Positioning**

**Issue:** Size Chart button injected via JavaScript at wrong location (after bundle selector instead of top of page)

**Impact:** Low - Not visible/accessible enough

**Fix Applied:** Updated JavaScript in 23-scripts.html to inject at beginning of product section

**Future Solution:**

- Size Chart button should be static HTML element, not JS-injected
- Position controlled by CSS/template structure

---

### 7. **Image Path Mismatches**

**Issue:** HTML expected `testimonials-##.png` (plural) but files were `testimonial-##.webp` (singular)

**Impact:** High - Testimonial images wouldn't load

**Fix Applied:** Copied files to create both versions

**Future Solution:**

- Standardize naming: use `testimonial-##.webp` everywhere
- Update HTML templates to match
- Build script validation: check all referenced images exist

---

### 8. **Rotating Reviews Contain Old Product Copy**

**Issue:** 5 hardcoded testimonials in rotating reviews still referenced "sequins" and "skirt"

**Impact:** High - Breaks product positioning, confuses customers

**Fix Applied:** Manually replaced with testimonials from product.config

**Future Solution:**

- Pull rotating reviews from product.config testimonials array
- Generate JS array dynamically during build
- Example: `const reviews = [{{TESTIMONIAL_1}}, {{TESTIMONIAL_2}}, ...]`

---

### 9. **Feature Cards Not Product-Specific**

**Issue:** Feature cards contained generic/old product features (sequin-specific)

**Impact:** High - Core product benefits not communicated

**Fix Applied:** Manually updated to dress-specific features

**Future Solution:**

- Add to product.config:

```bash
FEATURE_1="Structured Boning That Stays Put"
FEATURE_2="Premium Tulle & Chiffon"
FEATURE_3="No Slipping, No Adjusting"
FEATURE_4="Flattering Hourglass Silhouette"
```

- Replace in template: {{FEATURE_1}}, {{FEATURE_2}}, etc.

---

### 10. **Order Bump Logic Inconsistency**

**Issue:** Order bump logic unclear - should $59 bundle include order bump or not?

**Impact:** Medium - Incorrect pricing calculation

**Fix Applied:** Set logic: $19+checked=$29, $19+unchecked=$19, $59=always $59 (no order bump)

**Future Solution:**

- Add to product.config:

```bash
ORDER_BUMP_APPLIES_TO="single"  # or "both" or "none"
```

- Update JavaScript logic to read config

---

### 11. **Meta Descriptions Still Reference Old Product**

**Issue:** Meta descriptions, OG tags had sequin/skirt references

**Impact:** Medium - Poor SEO, wrong social sharing preview

**Fix Applied:** Ran rewrite-copy.sh script

**Future Solution:**

- Make ALL meta tags use variables:

```html
<meta name="description" content="{{META_DESCRIPTION}}" />
```

- Generate from buyer research if not provided

---

### 12. **No Build Validation Phase**

**Issue:** Template deploys without validating images exist, copy is updated, buttons work

**Impact:** High - Broken deployments go live

**Future Solution:**

- Add Phase 6: Validation
- Check: All images exist, no old copy references, forms work, pricing correct
- Exit build process if validation fails

---

## 🔧 Automation Improvements Needed

### Phase 4: AI-Powered Copy Generation

**Current:** Manual find/replace of old copy
**Needed:**

1. Read BUYER-RESEARCH.md
2. Use LLM to generate:
   - Main headlines
   - Subheadlines
   - Feature descriptions
   - Testimonial reinterpretations
   - Guarantee copy
   - Meta descriptions
3. Inject into sections/\*.html files
4. Replace hardcoded text blocks with {{VARIABLES}}

### Build Script Enhancements

**Add to build.py:**

1. Image validation: Check all src/srcset paths exist
2. Copy validation: Scan for old product references (regex patterns)
3. Form validation: Ensure only one ATC button, order bump logic correct
4. Config validation: All required fields filled
5. Generate warnings log before deployment

### Product Config Expansion

**Add these fields:**

```bash
# Features (4 items)
FEATURE_1=""
FEATURE_2=""
FEATURE_3=""
FEATURE_4=""

# Meta
META_DESCRIPTION=""
OG_DESCRIPTION=""

# Copy Control
ORDER_BUMP_PRECHECKED="true"
ORDER_BUMP_APPLIES_TO="single"

# Testimonials for rotating reviews
ROTATING_TESTIMONIAL_1=""
ROTATING_TESTIMONIAL_2=""
ROTATING_TESTIMONIAL_3=""
ROTATING_TESTIMONIAL_4=""
ROTATING_TESTIMONIAL_5=""
```

---

## 📋 Manual Workflow Improvements

### Phase Checklist Additions

**Phase 1: Research**

- ✅ No changes needed

**Phase 2: Images**

- ❌ Add: Validate all 35 images exist with correct naming
- ❌ Add: Standardize to `.webp` format only
- ❌ Add: Check comparison-01.png (bad) and comparison-02.png (good) exist

**Phase 3: Config**

- ❌ Add: Validate ALL config fields filled (not just required ones)
- ❌ Add: Prompt for feature cards text
- ❌ Add: Prompt for rotating testimonials

**Phase 4: Copy Rewrite** (NEW PHASE)

- ❌ Add: AI script that reads buyer research
- ❌ Add: Generate all sales copy programmatically
- ❌ Add: Inject into template sections
- ❌ Add: Validation scan for old product references

**Phase 5: Build**

- ❌ Add: Pre-build validation checks
- ❌ Add: Post-build validation (scan generated HTML)

**Phase 6: Deploy**

- ❌ Add: Post-deploy smoke tests
- ❌ Add: Screenshot comparison (before/after)
- ❌ Add: Broken link check

**Phase 7: Validation** (NEW PHASE)

- ❌ Add: Automated browser testing
- ❌ Add: Image load verification
- ❌ Add: Form submission test
- ❌ Add: Mobile responsiveness check

---

## 🐛 Known Issues Still Remaining

1. **Product carousel doesn't work** - No JavaScript loaded for slider functionality
2. **Some sequin/skirt references may remain** - rewrite-copy.sh reduced from 73 to 32, but manual check needed
3. **No form validation** - Size select can be empty on checkout
4. **No loading states** - Checkout button has no loading indicator

---

## ✅ Successfully Fixed Issues

1. ✅ Duplicate Add to Cart buttons
2. ✅ Order bump checkbox not pre-checked
3. ✅ Misplaced comparison image
4. ✅ Size Chart button positioning
5. ✅ Rotating reviews contain dress-specific copy
6. ✅ Feature cards updated
7. ✅ Meta descriptions updated
8. ✅ Pricing corrected ($19/$59/$10)

---

## 📝 Notes for Future Template Updates

### Template Structure Should Be:

```
sections/
  01-head.html          → All {{VARIABLES}}, no hardcoded copy
  05-main-product.html  → All features/copy from config
  06-comparison.html    → Before/after from config
  23-scripts.html       → Include slider JS, form validation

config/
  product.config        → Expanded with ALL customizable fields

scripts/
  build.py              → Add validation phases
  copy-generator.py     → NEW: AI copy generation from research
  validate.py           → NEW: Pre/post-build checks
```

### Testing Checklist (Run before every deployment):

- [ ] All 35 images load correctly
- [ ] Product carousel/slider works
- [ ] Only one Add to Cart button visible
- [ ] Order bump pre-checked (if configured)
- [ ] Correct pricing for all bundles
- [ ] Size Chart opens and closes
- [ ] Comparison slider works
- [ ] Mobile responsive on iPhone/Android
- [ ] No old product copy references
- [ ] Meta tags/OG images correct

---

**Last Updated:** 2026-01-09
**Next Review:** After 3 more product deployments to identify patterns
