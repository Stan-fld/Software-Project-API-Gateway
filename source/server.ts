import express, {Express} from "express";
import bodyParser from "body-parser";
import methodOverride from "method-override";
import {cors} from "./middleware/cors";
import {AuthenticationEndpoints} from "./server/endpoints/authentication/authentication-endpoints";
import {TransactionEndpoints} from "./server/endpoints/transactions/transactions-endpoints";

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


const PORT = 3300;
app.listen(PORT, () => console.log(`The server is running on port ${PORT}`));

export = app;
