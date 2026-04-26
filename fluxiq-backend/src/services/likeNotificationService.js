'use strict';

const fcmService        = require('./fcmService');
const userRepository    = require('../repositories/userRepository');
const notificationRepository = require('../repositories/notificationRepository');
const { checkMilestone } = require('../utils/milestoneChecker');
const logger = require('../utils/logger');

function truncate(text, maxLength) {
  if (!text) return '';
  return text.length <= maxLength
    ? text
    : `${text.substring(0, maxLength)}...`;
}


function buildLikeNotificationText(currentLikesCount) {
  if (currentLikesCount === 1) {
    return {
      title: '❤️ New Like',
      body:  'Someone liked your news article',
    };
  }
  return {
    title: '❤️ New Like',
    body:  'Someone else liked your news article',
  };
}

async function processLikeNotification({
  newsId,
  newsTitle,
  newsImageUrl,
  authorId,
  senderId,
  senderUsername,
  currentLikesCount,
}) {
  let fcmSent       = false;
  let fcmMessageId  = null;
  let inAppSaved    = false;
  let isMilestone   = false;
  let milestoneCount = null;

  if (authorId === senderId) {
    logger.info('processLikeNotification: self-like, skip', { authorId });
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
      recipientUserId:    authorId,
      senderUserId:       senderId,
      senderUsername,
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

  if (authorFcmToken) {
    const { title, body } = buildLikeNotificationText(currentLikesCount);

    const fcmResult = await fcmService.sendToDevice({
      token:authorFcmToken,
      title,
      body,
      imageUrl:  newsImageUrl || '',
      channelId: 'likes_channel',
      priority:  'normal',
      data: {
        type:   'like',
        newsId,
            newsImageUrl: newsImageUrl || '',
      },
    });

    if (fcmResult.success) {
      fcmSent      = true;
      fcmMessageId = fcmResult.messageId;
    } else if (fcmResult.invalidToken) {
      logger.warn('processLikeNotification: invalid token, removing', { authorId });
      try {
        await userRepository.removeUserFcmToken(authorId);
      } catch (removeError) {
        logger.error('processLikeNotification: failed to remove FCM token', removeError);
      }
    }
  } else {
    logger.warn('processLikeNotification: no FCM token for author', { authorId });
  }

  const milestone = checkMilestone(currentLikesCount);

  if (milestone !== null && authorFcmToken) {
    isMilestone    = true;
    milestoneCount = milestone;

    const milestoneTitle = '🎉 Achievement Unlocked!';
    const milestoneBody  =
      `Your article "${truncate(newsTitle, 40)}" reached ${milestone} likes!`;

    const milestoneResult = await fcmService.sendToDevice({
      token:     authorFcmToken,
      title:     milestoneTitle,
      body:      milestoneBody,
      imageUrl:  newsImageUrl || '',
      channelId: 'milestones_channel',
      priority:  'high',
      data: {
        type:'milestone',
        newsId,
           newsImageUrl: newsImageUrl || '',
        milestoneCount: String(milestone),
      },
    });

    if (milestoneResult.success) {
      logger.info('processLikeNotification: milestone sent', { milestone, newsId });
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

module.exports = { processLikeNotification };