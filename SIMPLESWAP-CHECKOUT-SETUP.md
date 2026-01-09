# SimpleSwap Checkout Setup Instructions

## ✅ Code Fixed

The Netlify function has been updated to work with the existing pool server.

---

## 🔧 Render Configuration Required

You need to update the pool server on Render.com with the correct price points:

### 1. Go to Render Dashboard

Visit: https://dashboard.render.com/web/sparkle-hoodie-pool

### 2. Update Environment Variables

Go to: **Environment** tab

Update `PRICE_POINTS` to:

```
19,29,59
```

(Current value is `25` - needs to be changed to support this product's pricing)

### 3. Add Allowed Origins

Add or update `ALLOWED_ORIGINS`:

```
https://dress2-auralo.netlify.app,https://dress2.auralo.store
```

### 4. Redeploy Service

After updating env vars:

- Click **Manual Deploy** → **Deploy latest commit**
- Wait 3-5 minutes for deployment

---

## 🚀 Initialize Pools

After server redeploys, initialize the exchange pools:

```bash
# Initialize all price point pools (creates 5 exchanges each)
curl -X POST https://sparkle-hoodie-pool.onrender.com/admin/init-pool

# Check pool status
curl https://sparkle-hoodie-pool.onrender.com/stats
```

**Expected Output:**

```json
{
  "pools": {
    "19": { "size": 5, "exchanges": [...] },
    "29": { "size": 5, "exchanges": [...] },
    "59": { "size": 5, "exchanges": [...] }
  }
}
```

---

## 🧪 Test Checkout Flow

### Test from Live Site:

1. Visit: https://dress2-auralo.netlify.app
2. Select bundle ($19 single or $59 bundle)
3. Check/uncheck order bump
4. Click "Add to Cart"
5. Should redirect to SimpleSwap payment page

### Test API Directly:

```bash
# Test $19 checkout
curl -X POST https://sparkle-hoodie-pool.onrender.com/buy-now \
  -H "Content-Type: application/json" \
  -d '{"amountUSD": 19}'

# Should return:
# {
#   "url": "https://simpleswap.io/exchange?id=abc123",
#   "exchangeId": "abc123"
# }
```

---

## 📊 Current Configuration

### Frontend (05-main-product.html):

```javascript
// Sends to: /api/buy-now
fetch("/api/buy-now", {
  method: "POST",
  body: JSON.stringify({ amountUSD: 19 }), // or 29 or 59
});
```

### Netlify Function (netlify/functions/buy-now.js):

```javascript
// Proxies to: https://sparkle-hoodie-pool.onrender.com/buy-now
const POOL_SERVER_URL = "https://sparkle-hoodie-pool.onrender.com";
```

### Pool Server (Render.com):

```javascript
// Returns exchange from pool for: $19, $29, or $59
POST /buy-now { amountUSD: 19 }
→ { url: "https://simpleswap.io/exchange?id=...", exchangeId: "..." }
```

---

## 🔄 Pricing Logic

| Selection      | Order Bump   | Total | Pool Used |
| -------------- | ------------ | ----- | --------- |
| 1x Dress ($19) | ✅ Checked   | $29   | 29 pool   |
| 1x Dress ($19) | ❌ Unchecked | $19   | 19 pool   |
| 2x Dress ($59) | ✅ or ❌     | $59   | 59 pool   |

---

## ⚠️ Important Notes

1. **Pool Depletion**: Each checkout removes 1 exchange from pool
   - Pool automatically refills when < 3 exchanges
   - Manual refill: `curl -X POST https://sparkle-hoodie-pool.onrender.com/admin/add-one -d '{"pricePoint":19}'`

2. **Server Sleep (Free Tier)**: If using free Render tier, server sleeps after 15min
   - First checkout after sleep: ~30 second delay
   - Solution: Upgrade to Starter plan ($7/month)

3. **Pool Initialization**: Must run `/admin/init-pool` after:
   - Changing PRICE_POINTS
   - Server restart
   - Clearing pools

---

## 📝 Quick Commands Reference

```bash
# Check pool status
curl https://sparkle-hoodie-pool.onrender.com/stats

# Initialize all pools
curl -X POST https://sparkle-hoodie-pool.onrender.com/admin/init-pool

# Add single exchange to $19 pool
curl -X POST https://sparkle-hoodie-pool.onrender.com/admin/add-one \
  -H "Content-Type: application/json" \
  -d '{"pricePoint": 19}'

# Test checkout
curl -X POST https://sparkle-hoodie-pool.onrender.com/buy-now \
  -H "Content-Type: application/json" \
  -d '{"amountUSD": 19}'
```

---

## ✅ Checklist

Before going live, verify:

- [ ] PRICE_POINTS updated on Render (19,29,59)
- [ ] ALLOWED_ORIGINS includes dress2-auralo domains
- [ ] Server redeployed after env var changes
- [ ] Pools initialized (`/admin/init-pool` returns success)
- [ ] `/stats` shows 5 exchanges in each pool (19, 29, 59)
- [ ] Test checkout redirects to SimpleSwap
- [ ] Merchant wallet receives test payment

---

**Last Updated:** 2026-01-09
