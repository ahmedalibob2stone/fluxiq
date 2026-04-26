'use strict';

const { admin } = require('../config/firebase.config');
const logger = require('../utils/logger');

const INVALID_TOKEN_ERRORS = [
'messaging/invalid-registration-token',
'messaging/registration-token-not-registered',
'messaging/invalid-argument',
];

async function sendToDevice({
token,
title,
body,
imageUrl = '',
channelId = 'default_channel',
data = {},
priority = 'high',
}) {
const stringifiedData = {};
for (const [key, value] of Object.entries(data)) {
stringifiedData[key] = String(value);
}

const message = {
token,
notification: {
title,
body,
...(imageUrl && { image: imageUrl }),
},
android: {
priority: priority === 'high' ? 'high' : 'normal',
notification: {
channelId,
sound: 'default',
      ...(imageUrl && { image: imageUrl }),
},
},
apns: {
headers: {
'apns-priority': priority === 'high' ? '10' : '5',
},
payload: {
aps: {
sound: 'default',
badge: 1,
contentAvailable: true,
},
},
fcmOptions: {
 ...(imageUrl && { imageUrl }),
 title: title,
     body: body,
     newsImageUrl: imageUrl || '',
},
},
data: {
...stringifiedData,
click_action: 'FLUTTER_NOTIFICATION_CLICK',
},
};

try {
const messageId = await admin.messaging().send(message);
logger.info('sendToDevice: notification sent', { messageId });
return { success: true, messageId };
} catch (error) {
const isInvalidToken = INVALID_TOKEN_ERRORS.includes(error.code);
logger.error('sendToDevice: FCM send failed', {
code: error.code,
message: error.message,
isInvalidToken,
});

if (isInvalidToken) {
  try {
    const usersRef = admin.firestore().collection('users');
    const snapshot = await usersRef
      .where('fcmToken', '==', token)
      .get();

    snapshot.forEach((doc) => {
      doc.ref.update({ fcmToken: null });
      logger.info('sendToDevice: invalid token removed for user', {
        userId: doc.id,
      });
    });
  } catch (deleteError) {
    logger.error('sendToDevice: failed to remove invalid token', {
      error: deleteError.message,
    });
  }
}

return {
  success: false,
  invalidToken: isInvalidToken,
  error: error.message,
};
}
}

async function sendToTopic({
topic,
title,
body,
imageUrl = '',
channelId = 'breaking_news_channel',
sound = 'breaking_news_sound',
data = {},
}) {
const stringifiedData = {};
for (const [key, value] of Object.entries(data)) {
stringifiedData[key] = String(value);
}

const message = {
topic,
notification: {
title,
body,
...(imageUrl && { image: imageUrl }),
},
android: {
priority: 'high',
notification: {
channelId,
sound,
priority: 'max',
visibility: 'public',
      ...(imageUrl && { image: imageUrl }),
},
},
apns: {
headers: {
'apns-priority': '10',
},
payload: {
aps: {
sound: `${sound}.wav`,
badge: 1,
contentAvailable: true,
mutableContent: true,
},
},
fcmOptions: {
      ...(imageUrl && { image: imageUrl }),
},
},
data: {
...stringifiedData,
  title: title,
    body: body,
    newsImageUrl: imageUrl || '',
    click_action: 'FLUTTER_NOTIFICATION_CLICK',
},
};

try {
const messageId = await admin.messaging().send(message);
logger.info('sendToTopic: broadcast sent', { topic, messageId });
return { success: true, messageId };
} catch (error) {
logger.error('sendToTopic: FCM topic send failed', {
code: error.code,
message: error.message,
});
return { success: false, error: error.message };
}
}

module.exports = {
sendToDevice,
sendToTopic,
};