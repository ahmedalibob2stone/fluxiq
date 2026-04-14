

const { auth } = require('../config/firebase.config');
const ApiResponse = require('../utils/response.helper');

async function verifyFirebaseToken(req, res, next) {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return ApiResponse.error(res, {
        message: 'Authorization token is required. Format: Bearer <token>',
        statusCode: 401,
      });
    }

    const idToken = authHeader.split('Bearer ')[1];

    if (!idToken || idToken.trim() === '') {
      return ApiResponse.error(res, {
        message: 'Token is empty',
        statusCode: 401,
      });
    }

    const decodedToken = await auth.verifyIdToken(idToken);

    req.user = {
      uid: decodedToken.uid,
      email: decodedToken.email,
      name: decodedToken.name || null,
    };

    next();

  } catch (error) {
    console.error('Token verification failed:', error.message);

    if (error.code === 'auth/id-token-expired') {
      return ApiResponse.error(res, {
        message: 'Token has expired. Please refresh your token.',
        statusCode: 401,
      });
    }

    if (error.code === 'auth/argument-error' || error.code === 'auth/id-token-revoked') {
      return ApiResponse.error(res, {
        message: 'Invalid token provided.',
        statusCode: 401,
      });
    }

    return ApiResponse.error(res, {
      message: 'Authentication failed',
      statusCode: 401,
      details: error.message,
    });
  }
}

module.exports = { verifyFirebaseToken };