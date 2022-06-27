import express, {Express} from "express";
import methodOverride from "method-override";
import {cors} from "./middleware/cors";
import {AuthenticationEndpoints} from "./server/endpoints/authentication/authentication-endpoints";
import {TransactionEndpoints} from "./server/endpoints/transactions/transactions-endpoints"
import morgan from "morgan";
import logger from "./middleware/logger";


const env = process.env.NODE_ENV;
const app: Express = express();

app.use(cors);
app.use(express.json());
app.use(methodOverride('X-HTTP-Method-Override'));
app.use(morgan(
        ':remote-addr - [:date[clf]] ":method :url HTTP/:http-version" :status :res[content-length] - :response-time ms',
        {
            stream: {
                // Use the http severity
                write: (message) => logger.http(message.trim())
            }
        }
    )
);

AuthenticationEndpoints.signUp(app);
AuthenticationEndpoints.signIn(app);
AuthenticationEndpoints.signOut(app);

TransactionEndpoints.transaction(app);

// Handling Errors and 404
app.use(function (req, res) {
    const error = [{
        name: 'NoExistingRoute',
        message: 'Route ' + req.originalUrl + ' with: ' + req.method + ' does not exist.',
        code: 404
    }];
    logger.warn(error[0]);
    res.status(404).send({data: error});
});

if (env !== "test") {
    const PORT = 3300;
    app.listen(PORT, () => console.log(`The server is running on port ${PORT}`));
}

export = app;
