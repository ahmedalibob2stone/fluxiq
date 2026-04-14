const rateLimit = require('express-rate-limit');


const passwordResetLimiter = rateLimit({

  windowMs: 15 * 60 * 1000,
  max: 5,
  standardHeaders: true,
  legacyHeaders: false,
  validate: false,
  message: {
    success: false,
    message: 'Too many attempts. Please try again after 15 minutes.',
  },
});

module.exports = { passwordResetLimiter };