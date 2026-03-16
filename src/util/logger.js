const path = require('node:path');
const winston = require('winston');
const config = require('../config');

const COLORIZE = config.NODE_ENV === 'development';

function createLogger(filePath) {
  const fileName = path.basename(filePath);

  const formats = [
    winston.format.label({ label: fileName }),
    winston.format.timestamp(),
    winston.format.splat(),
  ];

  if (COLORIZE) {
    formats.push(winston.format.colorize());
  }

  formats.push(
    winston.format.printf(({ level, message, label, timestamp }) => {
      return `${timestamp} [${label}] ${level}: ${message}`;
    }),
  );

  const logger = winston.createLogger({
    level: config.LOG_LEVEL || 'info',
    transports: [
      new winston.transports.Console({
        format: winston.format.combine(...formats),
      }),
    ],
  });

  return logger;
}

module.exports = createLogger;
