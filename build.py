#!/usr/bin/env python3
import glob
import os

os.chdir("/Users/nelsonchan/Downloads/nanobanana-manual-template copy 2")

# Load product config
config = {}
with open("product.config") as f:
    for line in f:
        line = line.strip()
        if "=" in line and not line.startswith("#"):
            key, value = line.split("=", 1)
            config[key] = value.strip('"')

# Concatenate sections
html = ""
section_files = sorted(glob.glob("sections/*.html"))
for section_file in section_files:
    with open(section_file) as f:
        html += f.read()

# Replace placeholders
replacements = {
    "{{PRODUCT_NAME}}": config.get("PRODUCT_NAME", ""),
    "{{BRAND_NAME}}": config.get("BRAND_NAME", ""),
    "{{PRODUCT_HANDLE}}": config.get("PRODUCT_HANDLE", ""),
    "{{SUBDOMAIN}}": config.get("SUBDOMAIN", ""),
    "{{SITE_URL}}": f"{config.get('SUBDOMAIN', '')}.auralo.store",
    "{{SINGLE_PRICE}}": config.get("SINGLE_PRICE", ""),
    "{{BUNDLE_PRICE}}": config.get("BUNDLE_PRICE", ""),
    "{{BUNDLE_OLD_PRICE}}": config.get("BUNDLE_OLD_PRICE", ""),
    "{{BUNDLE_SAVINGS}}": config.get("BUNDLE_SAVINGS", ""),
    "{{GUARANTEE_DAYS}}": config.get("GUARANTEE_DAYS", ""),
    "{{GUARANTEE_NAME}}": config.get("GUARANTEE_NAME", ""),
    "{{GUARANTEE_CONDITION}}": config.get("GUARANTEE_CONDITION", ""),
    "{{REVIEW_COUNT}}": config.get("REVIEW_COUNT", ""),
    "{{AUDIENCE}}": config.get("AUDIENCE", ""),
    "{{HEADLINE_HOOK}}": config.get("HEADLINE_HOOK", ""),
    "{{TAGLINE}}": config.get("TAGLINE", ""),
    "{{BEFORE_PAIN}}": config.get("BEFORE_PAIN", ""),
    "{{AFTER_BENEFIT}}": config.get("AFTER_BENEFIT", ""),
    "{{TESTIMONIAL_1}}": config.get("TESTIMONIAL_1", ""),
    "{{TESTIMONIAL_1_NAME}}": config.get("TESTIMONIAL_1_NAME", ""),
    "{{TESTIMONIAL_2}}": config.get("TESTIMONIAL_2", ""),
    "{{TESTIMONIAL_2_NAME}}": config.get("TESTIMONIAL_2_NAME", ""),
    "{{TESTIMONIAL_3}}": config.get("TESTIMONIAL_3", ""),
    "{{TESTIMONIAL_3_NAME}}": config.get("TESTIMONIAL_3_NAME", ""),
    "{{BUNDLE_DESCRIPTION}}": config.get("BUNDLE_DESCRIPTION", ""),
    "{{SINGLE_DESCRIPTION}}": config.get("SINGLE_DESCRIPTION", ""),
}

for placeholder, value in replacements.items():
    html = html.replace(placeholder, value)

# Write output
with open("index.html", "w") as f:
    f.write(html)

print("✅ index.html built successfully")
print(
    "📍 File: /Users/nelsonchan/Downloads/nanobanana-manual-template copy 2/index.html"
)
print("")
print("Open in browser:")
print(
    "open /Users/nelsonchan/Downloads/nanobanana-manual-template\\ copy\\ 2/index.html"
)
