'use strict';

const { db } = require('../config/firebase.config');
const logger = require('../utils/logger');

const NOTIFICATIONS_COLLECTION = 'notifications';
const BREAKING_NEWS_LOG_COLLECTION = 'breaking_news_log';

function generateNotificationId() {
  return db.collection(NOTIFICATIONS_COLLECTION).doc().id;
}

async function saveLikeNotification({
  recipientUserId,
  senderUserId,
  senderUsername,
  senderProfileImage,
  newsId,
  newsTitle,
  newsImageUrl,
}) {
  try {
    const notifId = generateNotificationId();
    const docRef = db.collection(NOTIFICATIONS_COLLECTION).doc(notifId);

    await docRef.set({
      id: notifId,
      recipientUserId,
      senderUserId,
      senderUsername,
      senderProfileImage: senderProfileImage || '',
      type: 'like',
      newsId,
      newsTitle,
      newsImageUrl: newsImageUrl || '',
      isRead: false,
      createdAt: new Date(),
    });

    logger.info('saveLikeNotification: saved', { notifId, recipientUserId });
    return notifId;
  } catch (error) {
    logger.error('saveLikeNotification: failed to save', error);
    throw error;
  }
}


async function saveBreakingNewsNotificationsForAllUsers({
  allUserIds,
  newsId,
  newsTitle,
  newsImageUrl,
  senderUserId,
}) {
  try {
    const BATCH_LIMIT = 500;
    const batches = [];

    for (let i = 0; i < allUserIds.length; i += BATCH_LIMIT) {
      const chunk = allUserIds.slice(i, i + BATCH_LIMIT);
      const batch = db.batch();

      for (const uid of chunk) {
        const notifId = generateNotificationId();
        const docRef = db.collection(NOTIFICATIONS_COLLECTION).doc(notifId);

        batch.set(docRef, {
          id: notifId,
          recipientUserId: uid,
          senderUserId: senderUserId || '',
          senderUsername: 'FluxIQ',
          senderProfileImage: '',
          type: 'breaking_news',
          newsId,
          newsTitle,
          newsImageUrl: newsImageUrl || '',
          isRead: false,
          createdAt: new Date(),
        });
      }

      batches.push(batch.commit());
    }

    await Promise.all(batches);

    logger.info('saveBreakingNewsNotificationsForAllUsers: done', {
      total: allUserIds.length,
      newsId,
    });
  } catch (error) {
    logger.error('saveBreakingNewsNotificationsForAllUsers: failed', error);
    throw error;
  }
}


async function saveBreakingNewsLog({
  newsId,
  newsTitle,
  recipientsCount,
  status,
}) {
  try {
    const docRef = db.collection(BREAKING_NEWS_LOG_COLLECTION).doc(newsId);

    await docRef.set({
      newsId,
      newsTitle,
      sentAt: new Date(),
      recipientsCount,
      status,
    });

    logger.info('saveBreakingNewsLog: log saved', { newsId, status });
  } catch (error) {
    logger.error('saveBreakingNewsLog: failed to save log', error);
  }
}

module.exports = {
  saveLikeNotification,
  saveBreakingNewsNotificationsForAllUsers,
  saveBreakingNewsLog,
};