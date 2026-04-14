const { setGlobalOptions } = require("firebase-functions/v2");
const { onCall, HttpsError } = require("firebase-functions/v2/https");
const admin = require("firebase-admin");
const geoip = require("geoip-lite");

setGlobalOptions({ maxInstances: 10 });

admin.initializeApp();

exports.addViewWithLocation = onCall(async (request) => {

  const { auth, data, rawRequest } = request;

  if (!auth) {
    throw new HttpsError(
      "unauthenticated",
      "User must be logged in"
    );
  }

  if (!data || !data.newsId) {
    throw new HttpsError(
      "invalid-argument",
      "newsId is required"
    );
  }

  const newsId = data.newsId;
  const userId = auth.uid;

  // استخراج IP الحقيقي من proxy
  const forwarded = rawRequest.headers["x-forwarded-for"];

  let ip = "Unknown";

  if (forwarded) {
    ip = forwarded.split(",")[0].trim();
  } else if (rawRequest.socket?.remoteAddress) {
    ip = rawRequest.socket.remoteAddress;
  }

  let country = "Unknown";
  let city = "Unknown";

  try {
    const geo = geoip.lookup(ip);

    if (geo) {
      country = geo.country || "Unknown";
      city = geo.city || "Unknown";
    }
  } catch (error) {
    console.error("Geo lookup error:", error);
  }

  const db = admin.firestore();

  const newsRef = db.collection("news").doc(newsId);
  const viewRef = newsRef.collection("views").doc(userId);

  await db.runTransaction(async (transaction) => {

    const viewDoc = await transaction.get(viewRef);

    if (viewDoc.exists) {
      return;
    }

    transaction.set(viewRef, {
      userId: userId,
      ip: ip,
      country: country,
      city: city,
      viewedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    transaction.update(newsRef, {
      viewsCount: admin.firestore.FieldValue.increment(1),
    });

  });

  return { success: true };

});