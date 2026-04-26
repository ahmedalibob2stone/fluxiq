'use strict';

const { processLikeNotification } = require('../services/likeNotificationService');
const ApiResponse = require('../utils/response.helper');
const logger = require('../utils/logger');


async function sendLikeNotification(req, res, next) {
  try {
    const {
      newsId,
      newsTitle,
      newsImageUrl,
      authorId,
      senderId,
      senderUsername,
      currentLikesCount,
    } = req.body;

    logger.info('sendLikeNotification: request received', {
      newsId,
      authorId,
      senderId,
    });

    const result = await processLikeNotification({
      newsId,
      newsTitle,
      newsImageUrl,
      authorId,
      senderId,
      senderUsername,
      currentLikesCount,
    });

    return ApiResponse.success(res, {
      message: result.reason === 'author_self_like'
        ? 'Self-like detected, notification skipped'
        : 'Notification processed successfully',
      statusCode: 200,
      data: {
        success: result.success,
        fcmSent: result.fcmSent,
        fcmMessageId: result.fcmMessageId,
        inAppSaved: result.inAppSaved,
        isMilestone: result.isMilestone,
        milestoneCount: result.milestoneCount,
        reason: result.reason,
      },
    });
  } catch (error) {
    logger.error('sendLikeNotification: unhandled error', error);
    next(error);
  }
}


function notificationHealth(req, res) {
  return ApiResponse.success(res, {
    message: 'Notification service is healthy',
    statusCode: 200,
    data: {
      service: 'FCM Notification Service',
      status: 'healthy',
      timestamp: new Date().toISOString(),
    },
  });
}

module.exports = {
  sendLikeNotification,
  notificationHealth,
};