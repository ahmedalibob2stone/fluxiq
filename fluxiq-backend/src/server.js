require('dotenv').config();
const app = require('./app');

const { startBreakingNewsWatcher } = require('./services/breakingNewsService');

const PORT = process.env.PORT || 3000;

function validateEnvVariables() {
  const required = [
    'RESEND_API_KEY',
      'FIREBASE_SERVICE_ACCOUNT_JSON',
      ]

  const missing = required.filter((key) => !process.env[key]);

  if (missing.length > 0) {
    console.error(`Missing environment variables: ${missing.join(', ')}`);
    process.exit(1);
  }
}

function startServer() {
  validateEnvVariables();

  app.listen(PORT, () => {
    console.log('🚀 ═══════════════════════════════════════');
    console.log(`🚀  Server is running on port: ${PORT}`);
    console.log(`🚀  Environment: ${process.env.NODE_ENV || 'development'}`);
    console.log(`🚀  Health: http://localhost:${PORT}/api/v1/health`);
    console.log('🚀 ═══════════════════════════════════════');
  });

  startBreakingNewsWatcher();
  console.log('👁️  Breaking News Watcher: ACTIVE');
}

startServer();