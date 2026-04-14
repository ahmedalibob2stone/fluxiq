'use strict';

const { db } = require('../config/firebase.config');
const logger = require('../utils/logger');

const USERS_COLLECTION = 'users';

async function getUserById(uid) {
  try {
    const docRef = db.collection(USERS_COLLECTION).doc(uid);
    const docSnap = await docRef.get();

    if (!docSnap.exists) {
      logger.warn('getUserById: user not found', { uid });
      return null;
    }

    return { id: docSnap.id, ...docSnap.data() };
  } catch (error) {
    logger.error('getUserById: failed to fetch user', error);
    throw error;
  }
}

async function getUserFcmToken(uid) {
  try {
    const user = await getUserById(uid);

    if (!user) return null;

    const token = user.fcmToken || null;

    if (!token) {
      logger.warn('getUserFcmToken: user has no FCM token', { uid });
    }

    return token;
  } catch (error) {
    logger.error('getUserFcmToken: error fetching FCM token', error);
    throw error;
  }
}


async function removeUserFcmToken(uid) {
  try {
    const docRef = db.collection(USERS_COLLECTION).doc(uid);
    await docRef.update({
      fcmToken: null,
      fcmTokenUpdatedAt: new Date(),
    });
    logger.info('removeUserFcmToken: FCM token removed', { uid });
  } catch (error) {
    logger.error('removeUserFcmToken: failed to remove FCM token', error);
    throw error;
  }
}



async function getAllUsersWithFcmToken() {
  try {
    const snapshot = await db
      .collection(USERS_COLLECTION)
      .where('fcmToken', '!=', null)
      .get();

    if (snapshot.empty) {
      logger.warn('getAllUsersWithFcmToken: no users with FCM tokens found');
      return [];
    }

    const users = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    logger.info('getAllUsersWithFcmToken: fetched users', { count: users.length });
    return users;
  } catch (error) {
    logger.error('getAllUsersWithFcmToken: failed to fetch users', error);
    throw error;
  }
}

async function getAllUserIds() {
  try {
    const snapshot = await db.collection(USERS_COLLECTION).get();

    if (snapshot.empty) return [];

    return snapshot.docs.map((doc) => doc.id);
  } catch (error) {
    logger.error('getAllUserIds: failed to fetch user IDs', error);
    throw error;
  }
}

module.exports = {
  getUserById,
  getUserFcmToken,
  removeUserFcmToken,
  getAllUsersWithFcmToken,
  getAllUserIds,
};