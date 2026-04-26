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

  logger.info('processBreakingNewsDoc: processing', {
    newsId,
    newsTitle,
    newsImageUrl,
  });

  let allUsers = [];
  let recipientsCount = 0;
  let logStatus = 'failed';

  const fcmResult = await fcmService.sendToTopic({
    topic: 'breaking_news',
    title: `🔴 خبر عاجل - ${category}`,
    body: newsTitle,
    imageUrl: newsImageUrl,
    channelId: 'breaking_news_channel',
    sound: 'breaking_news_sound',
    data: {
      type: 'breaking_news',
      newsId,
      newsImageUrl,
      category,
    },
  });

  if (fcmResult.success) {
    logStatus = 'sent';
    logger.info('processBreakingNewsDoc: FCM sent', { newsId });
  } else {
    logger.error('processBreakingNewsDoc: FCM failed', {
      error: fcmResult.error,
    });
  }

  try {
    allUsers = await userRepository.getAllUsers();
    recipientsCount = allUsers.length;

    if (allUsers.length > 0) {
      await notificationRepository.saveBreakingNewsNotificationsForAllUsers({
        newsId,
        newsTitle,
        newsImageUrl,
        senderUserId: authorId,
        allUsers,
      });
      logger.info('processBreakingNewsDoc: in-app saved', { recipientsCount });
    }
  } catch (error) {
    logger.error('processBreakingNewsDoc: failed to save in-app', error);
  }

  try {
    await notificationRepository.saveBreakingNewsLog({
      newsId,
      newsTitle,
      recipientsCount,
      status: logStatus,
      senderUserId: authorId,
      allUsers,
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

  const processedInSession = new Set();
  const processingNow = new Set();

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

        const unprocessedDocs = snapshot
          .docChanges()
          .filter((change) => {
            if (change.type !== 'added') return false;

            const data = change.doc.data();

            if (data.breakingNotificationSent === true) return false;

            const docId = change.doc.id;

            if (processedInSession.has(docId)) return false;

            if (processingNow.has(docId)) return false;

            return true;
          });

        if (unprocessedDocs.length === 0) return;

        logger.info('startBreakingNewsWatcher: detected unprocessed docs', {
          count: unprocessedDocs.length,
        });

        for (let i = 0; i < unprocessedDocs.length; i++) {
          const doc = unprocessedDocs[i].doc;
          const docId = doc.id;

          processedInSession.add(docId);
          processingNow.add(docId);

          try {
            await processBreakingNewsDoc(doc);
          } catch (err) {
            logger.error(
              'startBreakingNewsWatcher: error processing doc',
              { docId, error: err.message },
            );
          } finally {
            processingNow.delete(docId);
          }

          if (i < unprocessedDocs.length - 1) {
            await delay(DELAY_BETWEEN_BREAKING_NEWS_MS);
          }
        }
      },
      (error) => {
        logger.error(
          'startBreakingNewsWatcher: stream error — will reconnect',
          { message: error.message },
        );

        if (currentUnsubscribe) {
          try {
            currentUnsubscribe();
          } catch (_) {}
          currentUnsubscribe = null;
        }

        if (reconnectTimer) clearTimeout(reconnectTimer);

        reconnectTimer = setTimeout(() => {
          logger.info('startBreakingNewsWatcher: reconnecting now...');
          subscribe();
        }, RECONNECT_DELAY_MS);
      },
    );
  }

  subscribe();
  logger.info('startBreakingNewsWatcher: ACTIVE');

  return () => {
    isShuttingDown = true;
    if (reconnectTimer) clearTimeout(reconnectTimer);
    if (currentUnsubscribe) {
      try {
        currentUnsubscribe();
      } catch (_) {}
    }
    processedInSession.clear();
    processingNow.clear();
    logger.info('startBreakingNewsWatcher: stopped');
  };
}

module.exports = { startBreakingNewsWatcher };