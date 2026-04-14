
function getWelcomeEmailTemplate(userName) {
  return `
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Welcome to FluxIQ</title>
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
        ">

          <!-- Header with Gradient -->
          <tr>
            <td style="
              background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
              padding: 48px 40px;
              text-align: center;
            ">
              <h1 style="
                color: #ffffff;
                font-size: 32px;
                font-weight: 700;
                margin: 0 0 8px 0;
                letter-spacing: -0.5px;
              ">FluxIQ</h1>
              <p style="
                color: rgba(255,255,255,0.85);
                font-size: 16px;
                margin: 0;
              ">Welcome aboard! 🚀</p>
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
              ">Hello, ${userName}! 👋</h2>

              <p style="
                font-size: 16px;
                line-height: 1.7;
                color: #555555;
                margin: 0 0 24px 0;
              ">
                Thank you for joining <strong>FluxIQ</strong>! We're thrilled to have you
                as part of our community. Your account has been created successfully.
              </p>

              <p style="
                font-size: 16px;
                line-height: 1.7;
                color: #555555;
                margin: 0 0 32px 0;
              ">
                You're all set to explore everything we have to offer. If you ever need
                help, don't hesitate to reach out.
              </p>

              <!-- CTA Button -->
              <table role="presentation" cellspacing="0" cellpadding="0" style="margin: 0 auto;">
                <tr>
                  <td style="
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    border-radius: 12px;
                    text-align: center;
                  ">
                    <a href="#" style="
                      display: inline-block;
                      padding: 16px 48px;
                      color: #ffffff;
                      text-decoration: none;
                      font-size: 16px;
                      font-weight: 600;
                      letter-spacing: 0.5px;
                    ">Get Started</a>
                  </td>
                </tr>
              </table>

            </td>
          </tr>

          <!-- Divider -->
          <tr>
            <td style="padding: 0 40px;">
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
              padding: 32px 40px;
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
                font-size: 13px;
                color: #bbbbbb;
                margin: 0;
              ">
                This is an automated welcome message. You're receiving this because
                you signed up for a FluxIQ account.
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

module.exports = { getWelcomeEmailTemplate };