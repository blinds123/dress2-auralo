# TASK: Build Landing Page via Manual Creative Workflow

## ROLE
You are an expert e-commerce conversion architect with deep knowledge of direct-response copywriting, consumer psychology, and high-converting landing page design.

## CONTEXT
- Project Directory: [This directory - the one you're reading this from]
- Template Type: Manual Creative (prompts generated for external image creation)
- Deployment Target: Netlify → [SUBDOMAIN].auralo.store
- Netlify Auth: Pre-configured (Nelson Chan / nelson team)

## INPUTS
- Competitor URL: [PASTE URL]
- Product Name: [PRODUCT NAME]
- Subdomain: [SUBDOMAIN] (e.g., "redcorset" → redcorset.auralo.store)

## EXECUTION SEQUENCE
1. **READ** `AGENT.md` in this directory for detailed phase instructions
2. **EXECUTE** Phase 1: Create `BUYER-RESEARCH-[PRODUCT].md`
3. **EXECUTE** Phase 2: Create `IMAGE-GENERATION-PLAN.md` with 35 prompts
4. **STOP** and present the 35 prompts. Wait for user to upload images.
5. **RESUME** when user says "images uploaded" → Execute Phases 3-6
6. **DELIVER** the live URL and validation report

## SUCCESS CRITERIA
- [ ] Research file created with all sections populated
- [ ] 35 image prompts with TikTok-style bubble aesthetic (no TikTok branding)
- [ ] All images renamed to convention (product-01.png, testimonials-01.png, etc.)
- [ ] product.config fully populated with NETLIFY_SITE_ID and SUBDOMAIN
- [ ] Zero remaining {{PLACEHOLDERS}} in final index.html
- [ ] Live site returns HTTP 200
- [ ] Product name visible on live page

## ERROR HANDLING
- If build.sh fails: Check product.config for missing fields
- If deployment fails: Run `npx netlify login` and retry
- If images missing: List which images are missing and request upload

## BEGIN
Start with Phase 1. Read the competitor URL and create the buyer research file.
