import {Express} from "express";
import {createError, mongooseErrors} from "../errors/errors";
import {User} from "../../db/user.model";
import {bodyPick} from "../../middleware/utils";

export class Authentication {
    static signUp(app: Express) {

        app.post('/user', (req, res) => {

            const body = bodyPick(['firstName', 'lastName', 'email', 'password', 'phone', 'birthday', 'roles'], req.body.user);
            const clientInfo = bodyPick(['client', 'clientId'], req.body.clientInfo);

            if (clientInfo.client === undefined) {
                return res.status(400).send(createError('NoClientFound', 'Client required, no client found'));
            } else if (clientInfo.clientId == null) {
                return res.status(400).send(createError('NoClientIdFound', 'Client Id required, no id found'));
            }
            if (body.email === undefined) {
                return res.status(400).send(createError('NoEmailFound', 'Email address required, no address found'));
            }

            body.email = body.email.toLowerCase();

            const user = new User(body);

            user.createAuthToken(clientInfo.client, clientInfo.clientId).then((data: { user: User, token: { accessToken: any, refreshToken: any } }) => {

                if (data.token == null) {
                    return res.status(400).send(createError('CouldNotCreateToken', 'Could not create token'));
                }

                res.status(201).send({data: {user: data.user, tokens: data.token}});

            }).catch((e: Error) => {
                res.status(400).send(mongooseErrors(e));
            });

        });
    }

    static signIn(app: Express) {

        app.post('/user/login', (req, res) => {

            const body = bodyPick(['email', 'password', 'client', 'clientId'], req.body);

            if (body.client === undefined) {
                return res.status(400).send(createError('NoClientFound', 'Client required, no client found'));
            } else if (body.clientId === undefined) {
                return res.status(400).send(createError('NoClientIdFound', 'Client Id required, no id found'));
            }

            if (body.email === undefined) {
                return res.status(400).send(createError('NoEmailFound', 'Email address required, no address found'));
            } else if (body.password === undefined) {
                return res.status(400).send(createError('NoPasswordFound', 'Password is required, no password found'));
            }

            body.email = body.email.toLowerCase();


            User.findWithEmailPass(body.email, body.password).then((user: User) => {

                return user.createAuthToken(body.client, body.clientId);

            }).then((data) => {
                res.status(200).send({data: {currentUser: data.user, tokens: data.token}});
            }).catch((e) => {
                res.status(401).send(mongooseErrors(e));
            });
        });
    }
}
