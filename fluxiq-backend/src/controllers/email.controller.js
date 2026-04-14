

const EmailService = require('../services/email.service');
const ApiResponse = require('../utils/response.helper');

class EmailController {

  static async sendWelcomeEmail(req, res) {
    try {
      const { uid, email } = req.user;

      const name = req.body.name || req.user.name || 'User';

      if (!uid) {
        return ApiResponse.error(res, {
          message: 'User ID is required',
          statusCode: 400,
        });
      }

      if (!email) {
        return ApiResponse.error(res, {
          message: 'User email is required',
          statusCode: 400,
        });
      }

      const result = await EmailService.sendWelcomeEmail({ uid, email, name });


      if (result.reason === 'SUCCESS') {
        return ApiResponse.success(res, {
          message: result.message,
          data: { emailId: result.emailId },
          statusCode: 200,
        });
      }

      if (result.reason === 'ALREADY_SENT') {
        return ApiResponse.success(res, {
          message: result.message,
          data: { alreadySent: true },
          statusCode: 200,
        });
      }

      if (result.reason === 'USER_NOT_FOUND') {
        return ApiResponse.error(res, {
          message: result.message,
          statusCode: 404,
        });
      }

      if (result.reason === 'NO_EMAIL') {
        return ApiResponse.error(res, {
          message: result.message,
          statusCode: 400,
        });
      }

      return ApiResponse.error(res, {
        message: result.message,
        statusCode: 502,
        details: result.error,
      });

    } catch (error) {
      console.error(' EmailController Error:', error);
      return ApiResponse.error(res, {
        message: 'Internal server error while sending welcome email',
        statusCode: 500,
        details: error.message,
      });
    }
  }
}

module.exports = EmailController;