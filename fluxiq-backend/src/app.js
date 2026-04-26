const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const ApiResponse = require('./utils/response.helper');

const app = express();

app.set('trust proxy', 1);

app.use(helmet());

app.use(cors({
  origin: '*',
  methods: ['GET', 'POST'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));

app.use(express.json({ limit: '1mb' }));

if (process.env.NODE_ENV === 'development') {
  app.use(morgan('dev'));
} else {
  app.use(morgan('combined'));
}

app.get('/api/v1/health', (req, res) => {
  ApiResponse.success(res, {
    message: 'Server is running',
    data: {
      status: 'healthy',
      timestamp: new Date().toISOString(),
      environment: process.env.NODE_ENV || 'development',
    },
  });
});

const emailRoutes        = require('./routes/email.routes');
const authRoutes         = require('./routes/auth.routes');
const notificationRoutes = require('./routes/notification.routes');

app.use('/api/v1/email',emailRoutes);
app.use('/api/v1/auth', authRoutes);
app.use('/api/v1/notifications', notificationRoutes);

app.use((req, res) => {
  ApiResponse.error(res, {
    message: `Route not found: ${req.method} ${req.originalUrl}`,
    statusCode: 404,
  });
});

app.use((err, req, res, next) => {
  console.error('Unhandled Error:', err);
  ApiResponse.error(res, {
    message: 'Internal server error',
    statusCode: 500,
    details: err.message,
  });
});

module.exports = app;