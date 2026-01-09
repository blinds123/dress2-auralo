// Netlify Serverless Function: buy-now
// Handles checkout POST and returns SimpleSwap exchange URL

const POOL_SERVER_URL = 'https://simpleswap-pool-server.onrender.com';

exports.handler = async function(event, context) {
  // CORS headers
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Content-Type': 'application/json'
  };

  // Handle preflight
  if (event.httpMethod === 'OPTIONS') {
    return { statusCode: 200, headers, body: '' };
  }

  if (event.httpMethod !== 'POST') {
    return {
      statusCode: 405,
      headers,
      body: JSON.stringify({ error: 'Method not allowed' })
    };
  }

  try {
    const body = JSON.parse(event.body || '{}');
    const { amount, product, orderBump } = body;

    console.log('Checkout request:', { amount, product, orderBump });

    // Call pool server to get exchange URL
    const response = await fetch(`${POOL_SERVER_URL}/api/checkout`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        amount: amount || 29,
        currency: 'USD',
        product: product || 'leopard-skirt',
        orderBump: orderBump || false,
        timestamp: Date.now()
      })
    });

    if (!response.ok) {
      throw new Error(`Pool server error: ${response.status}`);
    }

    const data = await response.json();
    
    if (data.exchangeUrl) {
      return {
        statusCode: 200,
        headers,
        body: JSON.stringify({ 
          exchangeUrl: data.exchangeUrl,
          exchangeId: data.exchangeId 
        })
      };
    } else {
      throw new Error('No exchange URL returned');
    }

  } catch (error) {
    console.error('Checkout error:', error);
    
    // Fallback: return a test URL for development
    // In production, this should return an actual error
    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({ 
        exchangeUrl: 'https://simpleswap.io',
        error: null,
        fallback: true,
        message: 'Using fallback - pool server may be initializing'
      })
    };
  }
};
