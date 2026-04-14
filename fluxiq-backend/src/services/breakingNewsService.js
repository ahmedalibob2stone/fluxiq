'use strict';

const { db } = require('../config/firebase.config');
const fcmService = require('./fcmService');
const userRepository = require('../repositories/userRepository');
const notificationRepository = require('../repositories/notificationRepository');
const logger = require('../utils/logger');

const NEWS_COLLECTION = 'news';
const DELAY_BETWEEN_BREAKING_NEWS_MS = 2000;
const RECONNECT_DELAY_MS = 5000;

function delay(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function processBreakingNewsDoc(docSnapshot) {
  const newsId = docSnapshot.id;
  const data = docSnapshot.data();
  const newsRef = db.collection(NEWS_COLLECTION).doc(newsId);
  let committed = false;

  try {
    await db.runTransaction(async (transaction) => {
      const freshSnap = await transaction.get(newsRef);
      if (!freshSnap.exists) {
        logger.warn('processBreakingNewsDoc: doc no longer exists', { newsId });
        return;
      }
      const freshData = freshSnap.data();
      if (freshData.breakingNotificationSent === true) {
        logger.info('processBreakingNewsDoc: already sent, skip', { newsId });
        return;
      }
      transaction.update(newsRef, { breakingNotificationSent: true });
      committed = true;
    });
  } catch (error) {
    logger.error('processBreakingNewsDoc: transaction failed', error);
    return;
  }

  if (!committed) return;

  const newsTitle = data.title || '';
  const newsImageUrl = data.imageUrl || '';
  const category = data.category || 'عام';
  const authorId = data.authorId || '';

  logger.info('processBreakingNewsDoc: processing', { newsId, newsTitle });

  let recipientsCount = 0;
  let logStatus = 'failed';

  const fcmResult = await fcmService.sendToTopic({
    topic: 'breaking_news',
    title: `🔴 خبر عاجل - ${category}`,
    body: newsTitle,
    imageUrl: newsImageUrl,
    channelId: 'breaking_news_channel',
    sound: 'breaking_news_sound',
    data: { type: 'breaking_news', newsId, category },
  });

  if (fcmResult.success) {
    logStatus = 'sent';
    logger.info('processBreakingNewsDoc: FCM sent', { newsId });
  } else {
    logger.error('processBreakingNewsDoc: FCM failed', { error: fcmResult.error });
  }

  try {
    const allUserIds = await userRepository.getAllUserIds();
    recipientsCount = allUserIds.length;
    if (allUserIds.length > 0) {
      await notificationRepository.saveBreakingNewsNotificationsForAllUsers({
        allUserIds, newsId, newsTitle, newsImageUrl, senderUserId: authorId,
      });
      logger.info('processBreakingNewsDoc: in-app saved', { recipientsCount });
    }
  } catch (error) {
    logger.error('processBreakingNewsDoc: failed to save in-app', error);
  }

  try {
    await notificationRepository.saveBreakingNewsLog({
      newsId, newsTitle, recipientsCount, status: logStatus,
    });
  } catch (error) {
    logger.error('processBreakingNewsDoc: failed to save log', error);
  }
}

function startBreakingNewsWatcher() {
  logger.info('startBreakingNewsWatcher: starting...');

  let currentUnsubscribe = null;
  let reconnectTimer = null;
  let isShuttingDown = false;

  function subscribe() {
    if (isShuttingDown) return;

    logger.info('startBreakingNewsWatcher: subscribing...');

    const query = db
      .collection(NEWS_COLLECTION)
      .where('isBreaking', '==', true)
      .where('breakingNotificationSent', '==', false);

    currentUnsubscribe = query.onSnapshot(
      async (snapshot) => {
        if (snapshot.empty) return;

        const addedDocs = snapshot
          .docChanges()
          .filter((change) => change.type === 'added');

        if (addedDocs.length === 0) return;

        logger.info('startBreakingNewsWatcher: detected', {
          count: addedDocs.length,
        });

        for (let i = 0; i < addedDocs.length; i++) {
          await processBreakingNewsDoc(addedDocs[i].doc);
          if (i < addedDocs.length - 1) {
            await delay(DELAY_BETWEEN_BREAKING_NEWS_MS);
          }
        }
      },
      (error) => {
        logger.error('startBreakingNewsWatcher: stream error — will reconnect', {
          message: error.message,
        });

        if (currentUnsubscribe) {
          try { currentUnsubscribe(); } catch (_) {}
          currentUnsubscribe = null;
        }

        if (reconnectTimer) {
          clearTimeout(reconnectTimer);
        }

        reconnectTimer = setTimeout(() => {
          logger.info('startBreakingNewsWatcher: reconnecting now...');
          subscribe();
        }, RECONNECT_DELAY_MS);
      }
    );
  }

  subscribe();
  logger.info('startBreakingNewsWatcher: ACTIVE ');

  return () => {
    isShuttingDown = true;
    if (reconnectTimer) clearTimeout(reconnectTimer);
    if (currentUnsubscribe) {
      try { currentUnsubscribe(); } catch (_) {}
    }
    logger.info('startBreakingNewsWatcher: stopped');
  };
}

module.exports = { startBreakingNewsWatcher };

