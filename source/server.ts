import './config/config.js';
import express, {Express} from "express";
import bodyParser from "body-parser";
import methodOverride from "method-override";
import {cors} from "./middleware/cors";
import {AuthenticationEndpoints} from "./server/authentication/authentication-endpoints";
import {TransactionEndpoints} from "./server/transactions/transactions-endpoints";

import('./db/setup/db-mongoose-setup');
import mongoose from "mongoose";

import ('./db/setup/db-mysql-setup');
import sequelize from './db/setup/db-mysql-setup';


const env = process.env.NODE_ENV;
const app: Express = express();

app.use(cors);
app.use(bodyParser.json());
app.use(methodOverride('X-HTTP-Method-Override'));

AuthenticationEndpoints.signUp(app);
AuthenticationEndpoints.signIn(app);

TransactionEndpoints.transaction(app);

// Handling Errors and 404
app.use(function (req, res) {
    const error = [{
        name: 'NoExistingRoute',
        message: 'Route ' + req.originalUrl + ' with: ' + req.method + ' does not exist.',
        code: 404
    }];
    res.status(404).send({error});
});

if (env !== "test") {
    const PORT: any = process.env.PORT ?? 3000;
    app.listen(PORT, () => console.log(`The server is running on port ${PORT}`));
} else {
    afterAll(() => {
        mongoose.disconnect();
        sequelize.close();
    });
}

export = app;
