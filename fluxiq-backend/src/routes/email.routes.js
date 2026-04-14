
const express = require('express');
const router = express.Router();
const EmailController = require('../controllers/email.controller');
const { verifyFirebaseToken } = require('../middlewares/auth.middleware');


router.post(
  '/send-welcome',
  verifyFirebaseToken,
  EmailController.sendWelcomeEmail  ,
);

module.exports = router;