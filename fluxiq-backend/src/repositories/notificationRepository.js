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
  allUsers,
  newsId,
  newsTitle,
  newsImageUrl,
  senderUserId,
}) {
  try {
    const BATCH_LIMIT = 500;
    const batches = [];

    for (let i = 0; i < allUsers.length; i += BATCH_LIMIT) {
      const chunk = allUsers.slice(i, i + BATCH_LIMIT);
      const batch = db.batch();

      for (const user of chunk) {
        const notifId = generateNotificationId();
        const docRef = db.collection(NOTIFICATIONS_COLLECTION).doc(notifId);

        batch.set(docRef, {
          id: notifId,
          recipientUserId: user.id,
          senderUserId: senderUserId || '',
          senderUsername: 'FluxIQ',
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
       total: allUsers.length,
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
  senderUserId,
    allUsers,
}) {
  try {
    const docRef = db.collection(BREAKING_NEWS_LOG_COLLECTION).doc(newsId);

    await docRef.set({
      newsId,
      newsTitle,
      sentAt: new Date(),
      recipientsCount,
      status,
       senderUserId: senderUserId || '',
    });

    logger.info('saveBreakingNewsLog: log saved', { newsId, status });
        if (allUsers && allUsers.length > 0) {
          const BATCH_LIMIT = 500;
          const batches = [];

          for (let i = 0; i < allUsers.length; i += BATCH_LIMIT) {
            const chunk = allUsers.slice(i, i + BATCH_LIMIT);
            const batch = db.batch();

            for (const user of chunk) {
              const recipientRef = docRef
                .collection('recipients')
                .doc(user.id);

              batch.set(recipientRef, {
                userId: user.id,
                userName: user.username || user.displayName || 'Unknown',
                receivedAt: new Date(),
                status: status === 'sent' ? 'delivered' : 'failed',
              });
            }

            batches.push(batch.commit());
          }

          await Promise.all(batches);

          logger.info('saveBreakingNewsLog: recipients subcollection saved', {
            newsId,
            count: allUsers.length,
          });
        }
  } catch (error) {
    logger.error('saveBreakingNewsLog: failed to save log', error);
    throw error;
  }
}

module.exports = {
  saveLikeNotification,
  saveBreakingNewsNotificationsForAllUsers,
  saveBreakingNewsLog,
};