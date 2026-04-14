'use strict';

const LOG_LEVELS = {
  INFO: 'INFO',
  WARN: 'WARN',
  ERROR: 'ERROR',
  DEBUG: 'DEBUG',
};


function getTimestamp() {
  return new Date().toISOString();
}

function formatLog(level, message, meta = null) {
  const base = `[${getTimestamp()}] [${level}] ${message}`;
  if (meta) {
    return `${base} | ${JSON.stringify(meta)}`;
  }
  return base;
}

const logger = {

  info(message, meta = null) {
    console.log(formatLog(LOG_LEVELS.INFO, message, meta));
  },

  warn(message, meta = null) {
    console.warn(formatLog(LOG_LEVELS.WARN, message, meta));
  },


  error(message, error = null) {
    if (error instanceof Error) {
      console.error(formatLog(LOG_LEVELS.ERROR, message, {
        message: error.message,
        stack: error.stack,
      }));
    } else {
      console.error(formatLog(LOG_LEVELS.ERROR, message, error));
    }
  },

  debug(message, meta = null) {
    if (process.env.NODE_ENV === 'development') {
      console.debug(formatLog(LOG_LEVELS.DEBUG, message, meta));
    }
  },
};

module.exports = logger;