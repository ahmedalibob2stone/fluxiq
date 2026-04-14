

const PasswordService = require('../services/password.service');
const ApiResponse = require('../utils/response.helper');

class AuthController {

  static async forgotPassword(req, res) {
    try {
      const { email } = req.body;

      if (!email || typeof email !== 'string') {
        return ApiResponse.error(res, {
          message: 'Email address is required',
          statusCode: 400,
        });
      }

      const cleanEmail = email.toLowerCase().trim();

      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(cleanEmail)) {
        return ApiResponse.error(res, {
          message: 'Please provide a valid email address',
          statusCode: 400,
        });
      }

      const result = await PasswordService.handlePasswordReset(cleanEmail);

      if (result.success) {
        return ApiResponse.success(res, {
          message: result.message,
          statusCode: 200,
        });
      }

      return ApiResponse.error(res, {
        message: result.message,
        statusCode: 502,
        details: result.error,
      });

    } catch (error) {
      console.error('AuthController.forgotPassword Error:', error);

      if (error.code === 'auth/invalid-email') {
        return ApiResponse.error(res, {
          message: 'The email address format is invalid',
          statusCode: 400,
        });
      }

      return ApiResponse.error(res, {
        message: 'Something went wrong. Please try again later.',
        statusCode: 500,
        details: error.message,
      });
    }
  }
}

module.exports = AuthController;