
function getPasswordResetTemplate(resetLink) {
  return `
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Reset Your Password - FluxIQ</title>
</head>
<body style="
  margin: 0;
  padding: 0;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background-color: #f4f7fa;
  color: #333333;
">
  <!-- Main Container -->
  <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="
    background-color: #f4f7fa;
    padding: 40px 20px;
  ">
    <tr>
      <td align="center">
        <!-- Email Card -->
        <table role="presentation" width="600" cellspacing="0" cellpadding="0" style="
          background-color: #ffffff;
          border-radius: 16px;
          overflow: hidden;
          box-shadow: 0 4px 24px rgba(0,0,0,0.08);
          max-width: 600px;
          width: 100%;
        ">

          <!-- Header with Gradient -->
          <tr>
            <td style="
              background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
              padding: 48px 40px;
              text-align: center;
            ">
              <!-- Lock Icon -->
              <div style="
                width: 72px;
                height: 72px;
                margin: 0 auto 20px auto;
                background-color: rgba(255,255,255,0.2);
                border-radius: 50%;
                line-height: 72px;
                font-size: 32px;
              ">🔐</div>

              <h1 style="
                color: #ffffff;
                font-size: 28px;
                font-weight: 700;
                margin: 0 0 8px 0;
                letter-spacing: -0.5px;
              ">FluxIQ</h1>
              <p style="
                color: rgba(255,255,255,0.85);
                font-size: 16px;
                margin: 0;
              ">Password Reset Request</p>
            </td>
          </tr>

          <!-- Body Content -->
          <tr>
            <td style="padding: 48px 40px;">

              <h2 style="
                font-size: 22px;
                font-weight: 600;
                color: #1a1a2e;
                margin: 0 0 16px 0;
              ">Reset Your Password</h2>

              <p style="
                font-size: 16px;
                line-height: 1.7;
                color: #555555;
                margin: 0 0 12px 0;
              ">
                We received a request to reset the password associated with your
                <strong>FluxIQ</strong> account. Click the button below to create
                a new password.
              </p>

              <p style="
                font-size: 14px;
                line-height: 1.6;
                color: #888888;
                margin: 0 0 32px 0;
              ">
                This link will expire in <strong>1 hour</strong> for security reasons.
                If you didn't request this, you can safely ignore this email.
              </p>

              <!-- CTA Button -->
              <table role="presentation" cellspacing="0" cellpadding="0" width="100%">
                <tr>
                  <td align="center">
                    <table role="presentation" cellspacing="0" cellpadding="0">
                      <tr>
                        <td style="
                          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                          border-radius: 12px;
                          text-align: center;
                        ">
                          <a href="${resetLink}" target="_blank" style="
                            display: inline-block;
                            padding: 18px 56px;
                            color: #ffffff;
                            text-decoration: none;
                            font-size: 16px;
                            font-weight: 600;
                            letter-spacing: 0.5px;
                          ">Reset Password</a>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>

              <!-- Fallback Link -->
              <p style="
                font-size: 13px;
                line-height: 1.6;
                color: #aaaaaa;
                margin: 28px 0 0 0;
                text-align: center;
              ">
                If the button doesn't work, copy and paste this link into your browser:
              </p>
              <p style="
                font-size: 12px;
                line-height: 1.5;
                color: #667eea;
                word-break: break-all;
                text-align: center;
                margin: 8px 0 0 0;
                padding: 12px 16px;
                background-color: #f8f9fc;
                border-radius: 8px;
              ">
                ${resetLink}
              </p>

            </td>
          </tr>

          <!-- Security Notice -->
          <tr>
            <td style="padding: 0 40px;">
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="
                background-color: #fff8f0;
                border-radius: 10px;
                border-left: 4px solid #f0a050;
              ">
                <tr>
                  <td style="padding: 16px 20px;">
                    <p style="
                      font-size: 13px;
                      color: #996633;
                      margin: 0;
                      line-height: 1.6;
                    ">
                      ⚠️ <strong>Security Tip:</strong> FluxIQ will never ask you for
                      your password via email. If you didn't request this reset,
                      please secure your account immediately.
                    </p>
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <!-- Divider -->
          <tr>
            <td style="padding: 32px 40px 0 40px;">
              <hr style="
                border: none;
                border-top: 1px solid #e8ecf1;
                margin: 0;
              " />
            </td>
          </tr>

          <!-- Footer -->
          <tr>
            <td style="
              padding: 24px 40px 32px 40px;
              text-align: center;
            ">
              <p style="
                font-size: 13px;
                color: #999999;
                margin: 0 0 8px 0;
              ">
                © ${new Date().getFullYear()} FluxIQ. All rights reserved.
              </p>
              <p style="
                font-size: 12px;
                color: #bbbbbb;
                margin: 0;
              ">
                You received this email because a password reset was requested
                for your FluxIQ account.
              </p>
            </td>
          </tr>

        </table>
      </td>
    </tr>
  </table>
</body>
</html>
  `;
}

module.exports = { getPasswordResetTemplate };