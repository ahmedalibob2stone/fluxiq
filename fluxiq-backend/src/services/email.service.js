

const { db } = require('../config/firebase.config');
const { resend } = require('../config/resend.config');
const { getWelcomeEmailTemplate } = require('../templates/welcome.template');

class EmailService {


  static async sendWelcomeEmail({ uid, email, name }) {
    const userRef = db.collection('users').doc(uid);
    const userDoc = await userRef.get();

    if (!userDoc.exists) {
      return {
        sent: false,
        reason: 'USER_NOT_FOUND',
        message: 'User document not found in Firestore',
      };
    }

    const userData = userDoc.data();

    if (userData.welcomeEmailSent === true) {
      return {
        sent: false,
        reason: 'ALREADY_SENT',
        message: 'Welcome email has already been sent to this user',
      };
    }
    const userName = name || userData.name || 'User';
    const userEmail = email || userData.email;

    if (!userEmail) {
      return {
        sent: false,
        reason: 'NO_EMAIL',
        message: 'User email address is missing',
      };
    }

    const { data, error } = await resend.emails.send({
      from: process.env.EMAIL_FROM || 'FluxIQ <onboarding@resend.dev>',
      to: [userEmail],
      subject: `Welcome to FluxIQ, ${userName}! `,
      html: getWelcomeEmailTemplate(userName),
    });

    if (error) {
      console.error(' Resend API Error:', error);
      return {
        sent: false,
        reason: 'EMAIL_SERVICE_ERROR',
        message: 'Failed to send email through Resend',
        error: error.message,
      };
    }

    await userRef.update({
      welcomeEmailSent: true,
      welcomeEmailSentAt: new Date().toISOString(),
    });

    console.log(` Welcome email sent successfully to: ${userEmail} (ID: ${data.id})`);

    return {
      sent: true,
      reason: 'SUCCESS',
      message: 'Welcome email sent successfully',
      emailId: data.id,
    };
  }
}

module.exports = EmailService;