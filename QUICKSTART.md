# QUICKSTART

Copy and paste this prompt to any AI (Gemini, Claude, GPT) to start a new landing page.

---

## Starting Prompt (Images Already Uploaded)

```
I'm using the nanobanana template. Read AGENT.md.

INPUTS:
- Competitor URL: [PASTE URL]
- Product: [PRODUCT NAME]

IMAGES:
I've placed images in the images/ subfolders but they need renaming.
Read phases/2-images.md for the exact naming convention, then:
1. List all images in each subfolder
2. Rename them to match the convention
3. Report what was renamed

After images are organized, complete Phase 1 → 3 → 4 → 5.

Start by listing the images in each folder.
```

---

## Starting Prompt (No Images Yet)

```
I'm using the nanobanana template. Read AGENT.md for the complete workflow.

INPUTS:
- Competitor URL: [PASTE URL]
- Product: [PRODUCT NAME]
- I will provide product images manually

Complete all 5 phases in order.
Start with Phase 1: Read phases/1-research.md and analyze the competitor URL.
```

---

## Workflow Summary

| Phase | What Happens |
|-------|--------------|
| 1 | Buyer research from competitor URL |
| 2 | Organize/rename images |
| 3 | Fill product.config |
| 4 | Rewrite sales copy |
| 5 | Build and deploy |

---

## Files to Know

- `AGENT.md` - Main workflow (AI reads this first)
- `phases/` - Detailed instructions for each phase
- `product.config` - Fill with your product details
- `build.sh` - Run to build and deploy
