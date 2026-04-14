'use strict';

const fcmService = require('./fcmService');
const userRepository = require('../repositories/userRepository');
const notificationRepository = require('../repositories/notificationRepository');
const { checkMilestone } = require('../utils/milestoneChecker');
const logger = require('../utils/logger');

function truncate(text, maxLength) {
  if (!text) return '';
  if (text.length <= maxLength) return text;
  return `${text.substring(0, maxLength)}...`;
}

async function processLikeNotification({
  newsId,
  newsTitle,
  newsImageUrl,
  authorId,
  senderId,
  senderUsername,
  senderProfileImage,
  currentLikesCount,
}) {
  let fcmSent = false;
  let fcmMessageId = null;
  let inAppSaved = false;
  let isMilestone = false;
  let milestoneCount = null;

  if (authorId === senderId) {
    logger.info('processLikeNotification: author liked own article, skip', {
      authorId,
    });
    return {
      success: true,
      fcmSent: false,
      fcmMessageId: null,
      inAppSaved: false,
      isMilestone: false,
      milestoneCount: null,
      reason: 'author_self_like',
    };
  }

  try {
    await notificationRepository.saveLikeNotification({
      recipientUserId: authorId,
      senderUserId: senderId,
      senderUsername,
      senderProfileImage,
      newsId,
      newsTitle,
      newsImageUrl,
    });
    inAppSaved = true;
  } catch (error) {
    logger.error('processLikeNotification: failed to save in-app notification', error);
  }

  let authorFcmToken = null;
  try {
    authorFcmToken = await userRepository.getUserFcmToken(authorId);
  } catch (error) {
    logger.error('processLikeNotification: failed to get FCM token', error);
  }

  // ── STEP 3: Send FCM push notification ────────────────────────────────────
  if (authorFcmToken) {
    const notifTitle = '❤️ إعجاب جديد';
    const notifBody = `${senderUsername} أعجب بخبرك: ${truncate(newsTitle, 50)}`;

    const fcmResult = await fcmService.sendToDevice({
      token: authorFcmToken,
      title: notifTitle,
      body: notifBody,
      imageUrl: newsImageUrl,
      channelId: 'likes_channel',
      priority: 'normal',
      data: {
        type: 'like',
        newsId,
      },
    });

    if (fcmResult.success) {
      fcmSent = true;
      fcmMessageId = fcmResult.messageId;
    } else if (fcmResult.invalidToken) {
      logger.warn('processLikeNotification: invalid FCM token, removing', {
        authorId,
      });
      try {
        await userRepository.removeUserFcmToken(authorId);
      } catch (removeError) {
        logger.error('processLikeNotification: failed to remove FCM token', removeError);
      }
    }
  } else {
    logger.warn('processLikeNotification: author has no FCM token, skip push', {
      authorId,
    });
  }

  const milestone = checkMilestone(currentLikesCount);

  if (milestone !== null && authorFcmToken) {
    isMilestone = true;
    milestoneCount = milestone;

    const milestoneTitle = '🎉 إنجاز جديد!';
    const milestoneBody = `وصل خبرك '${truncate(newsTitle, 40)}' إلى ${milestone} إعجاب!`;

    const milestoneResult = await fcmService.sendToDevice({
      token: authorFcmToken,
      title: milestoneTitle,
      body: milestoneBody,
      imageUrl: newsImageUrl,
      channelId: 'likes_channel',
      priority: 'normal',
      data: {
        type: 'milestone',
        newsId,
        milestoneCount: String(milestone),
      },
    });

    if (milestoneResult.success) {
      logger.info('processLikeNotification: milestone notification sent', {
        milestone,
        newsId,
      });
    }
  }

  return {
    success: true,
    fcmSent,
    fcmMessageId,
    inAppSaved,
    isMilestone,
    milestoneCount,
    reason: null,
  };
}

module.exports = {
  processLikeNotification,
};