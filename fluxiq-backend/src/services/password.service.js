

const { auth } = require('../config/firebase.config');
const { resend } = require('../config/resend.config');
const { getPasswordResetTemplate } = require('../templates/password-reset.template');

class PasswordService {


  static async handlePasswordReset(email) {

    try {
      await auth.getUserByEmail(email);
    } catch (error) {
      if (error.code === 'auth/user-not-found') {

        return {
          success: true,
          reason: 'PROCESSED',
          message: 'If this email is registered, a reset link has been sent.',
        };
      }
      throw error;
    }

  const resetLink = await auth.generatePasswordResetLink(email, {
    url: 'https://fluxiq.onrender.com/reset-success',
  });

    const { data, error } = await resend.emails.send({
      from: process.env.EMAIL_FROM || 'FluxIQ <onboarding@resend.dev>',
      to: [email],
      subject: 'Reset Your Password - FluxIQ ',
      html: getPasswordResetTemplate(resetLink),
    });

    if (error) {
      console.error(' Resend API Error (Password Reset):', error);
      return {
        success: false,
        reason: 'EMAIL_SERVICE_ERROR',
        message: 'Failed to send password reset email. Please try again later.',
        error: error.message,
      };
    }

    console.log(` Password reset email sent to: ${email} (Resend ID: ${data.id})`);

    return {
      success: true,
      reason: 'SENT',
      message: 'If this email is registered, a reset link has been sent.',
      emailId: data.id,
    };
  }
}

module.exports = PasswordService;