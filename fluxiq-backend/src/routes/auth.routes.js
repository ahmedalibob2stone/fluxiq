

const express = require('express');
const router = express.Router();
const AuthController = require('../controllers/auth.controller');
const { passwordResetLimiter } = require('../middlewares/rate-limiter.middleware');

router.post(
  '/forgot-password',
  passwordResetLimiter,
  AuthController.forgotPassword
);

module.exports = router;