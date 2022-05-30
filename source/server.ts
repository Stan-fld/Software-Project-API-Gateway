require("./config/config" + (process.env.NODE_ENV === 'production' ? ".js" : ".ts"));

import express, {Express} from "express";
import bodyParser from "body-parser";
import methodOverride from "method-override";
import {cors} from "./middleware/cors";
import {Authentication} from "./server/authentication/authentication";
import {UserEndpoints} from "./server/user/user";
import {AdminUsersEndpoints} from "./server/admin/admin-user";
import mongoose from "mongoose";
import("./db/db-mongoose-setup");

const env = process.env.NODE_ENV;
const app: Express = express();

app.use(cors);
app.use(bodyParser.json());
app.use(methodOverride('X-HTTP-Method-Override'));

Authentication.signUp(app);
Authentication.signIn(app);

AdminUsersEndpoints.fetchUsers(app);
AdminUsersEndpoints.deleteUser(app);

UserEndpoints.updateUser(app);
UserEndpoints.changeUserPassword(app);

// Handling Errors and 404
app.use(function (req, res) {
    const error = [{
        name: 'NoExistingRoute',
        message: 'Route ' + req.originalUrl + ' with: ' + req.method + ' does not exist.',
        code: null
    }];
    if (env !== "production") {
        const routes = app._router.stack
            .filter(r => r.route !== undefined)
            .map((r) => {
                return {Route: r.route.path, Method: r.route.methods};
            });
        res.status(404).send({
            error,
            "You can use these routes": routes
        });
    } else {
        res.status(404).send({error});
    }
});

if (env !== "test") {
    const PORT: any = process.env.PORT ?? 3000;
    app.listen(PORT, () => console.log(`The server is running on port ${PORT}`));
} else {
    afterAll(() => mongoose.disconnect());
}

export = app;
