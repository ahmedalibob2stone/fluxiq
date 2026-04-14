const admin = require('firebase-admin');
const path = require('path');

let serviceAccount;

if (process.env.FIREBASE_SERVICE_ACCOUNT_JSON) {
  const value = process.env.FIREBASE_SERVICE_ACCOUNT_JSON.trim();

  if (value.startsWith('{')) {
    serviceAccount = JSON.parse(value);
  } else {
    serviceAccount = require(path.resolve(value));
  }
} else {
  serviceAccount = require(path.resolve('./firebase-service-account.json'));
}

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const auth = admin.auth();
const db = admin.firestore();

module.exports = { admin, auth, db };