import winston from "winston";
import dailyRotateFile from 'winston-daily-rotate-file';

// Define your severity levels.
// With them, You can create log files.
const levels = {
    error: 0,
    warn: 1,
    http: 2,
    info: 3,
}

const colors = {
    error: 'red',
    warn: 'yellow',
    http: 'magenta',
    info: 'green',
}

winston.addColors(colors)

const baseFormat = winston.format.combine(
    // Add the message timestamp with the preferred format
    winston.format.timestamp({format: 'YYYY-MM-DD HH:mm:ss:ms'}),
    // Define the format of the message
    winston.format.printf(
        (info) => `${info.timestamp} ${info.level}: ${info.message}`,
    )
);

const consoleFormat = baseFormat && winston.format.colorize({all: true});

// Define which transports the logger must use to print out messages.
// In this example, we are using three different transports
const transports = [
    // Allow the use the console to print the messages
    new winston.transports.Console({format: consoleFormat}),

    // Allow to print all the error message inside the all.log file
    new dailyRotateFile({filename: 'logs/%DATE%.log', maxFiles: 2, format: baseFormat && winston.format.json()}),
]

// Create the logger instance that has to be exported
// and used to log messages.
const logger = winston.createLogger({
    levels: levels,
    format: baseFormat,
    transports,
})

export default logger;
