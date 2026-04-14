'use strict';

const express = require('express');
const rateLimit = require('express-rate-limit');
const { z } = require('zod');
const notificationController = require('../controllers/notificationController');
const validateRequest = require('../middlewares/validateRequest');

const router = express.Router();

const notificationRateLimiter = rateLimit({
  windowMs: parseInt(process.env.RATE_LIMIT_WINDOW_MS, 10) || 60 * 1000,
  max: parseInt(process.env.RATE_LIMIT_MAX_REQUESTS, 10) || 100,
  standardHeaders: true,
  legacyHeaders: false,
  message: {
    success: false,
    message: 'Too many requests, please try again later.',
  },
});

const likeNotificationSchema = z.object({
  newsId: z
    .string({ required_error: 'newsId is required' })
    .min(1, 'newsId cannot be empty'),

  newsTitle: z
    .string({ required_error: 'newsTitle is required' })
    .min(1, 'newsTitle cannot be empty'),

  newsImageUrl: z
    .string()
    .url('newsImageUrl must be a valid URL')
    .optional()
    .or(z.literal('')),

  authorId: z
    .string({ required_error: 'authorId is required' })
    .min(1, 'authorId cannot be empty'),

  senderId: z
    .string({ required_error: 'senderId is required' })
    .min(1, 'senderId cannot be empty'),

  senderUsername: z
    .string({ required_error: 'senderUsername is required' })
    .min(1, 'senderUsername cannot be empty'),

  senderProfileImage: z
    .string()
    .optional()
    .or(z.literal('')),

  currentLikesCount: z
    .number({ required_error: 'currentLikesCount is required' })
    .int('currentLikesCount must be an integer')
    .min(0, 'currentLikesCount cannot be negative'),
});


router.get('/health', notificationController.notificationHealth);


router.post(
  '/like',
  notificationRateLimiter,
  validateRequest(likeNotificationSchema),
  notificationController.sendLikeNotification
);

module.exports = router;