import {Express} from "express";
import {createError, mongooseErrors} from "../errors/errors";
import {bodyPick} from "../../middleware/utils";
import {authenticateIpAndRole} from "../../middleware/authenticate";
import axios from 'axios';
import {TransactionToken} from "../../db/transaction-token.model";

export class Authentication {
    static signUp(app: Express) {

        app.post('/register/:transactionCode', authenticateIp, (req: any, res) => {

            const transactionCode = req.params.transactionCode;

            const body = bodyPick(['email'], req.body.user);
            const clientInfo = bodyPick(['client', 'clientId'], req.body.clientInfo);

            if (clientInfo.client === undefined) {
                return res.status(400).send(createError('NoClientFound', 'Client required, no client found'));
            } else if (clientInfo.clientId == null) {
                return res.status(400).send(createError('NoClientIdFound', 'Client Id required, no id found'));
            }
            if (body.email === undefined) {
                return res.status(400).send(createError('NoEmailFound', 'Email address required, no address found'));
            }

            req.body.email = body.email.toLowerCase();

            const transactionToken = new TransactionToken()
            transactionToken.createTransactionToken(transactionCode).then((transactionToken: TransactionToken) => {

                if (!transactionToken) {
                    return res.status(400).send(createError('CouldNotCreateToken', 'Could not create token'));
                }

                axios.post(
                    'https://api.hinna.fr/item_public',
                    {body: req.body},
                    {
                        headers: {
                            'Content-Type': 'application/json',
                            'trx-auth': transactionToken.token
                        }
                    }).then((axiosRes) => {

                    return res.status(201).send({msg: 'ok'});

                }).catch((e) => {
                    console.log(e);
                });

            }).catch((e: Error) => {
                res.status(400).send(mongooseErrors(e));
            });

        });
    }

    static signIn(app: Express) {

        app.post('/login/:transactionCode', authenticateIp, (req: any, res) => {

            const transactionCode = req.params.transactionCode;

            const body = bodyPick(['email', 'password'], req.body);
            const clientInfo = bodyPick(['client', 'clientId'], req.body);

            if (clientInfo.client === undefined) {
                return res.status(400).send(createError('NoClientFound', 'Client required, no client found'));
            } else if (clientInfo.clientId === undefined) {
                return res.status(400).send(createError('NoClientIdFound', 'Client Id required, no id found'));
            }

            if (body.email === undefined) {
                return res.status(400).send(createError('NoEmailFound', 'Email address required, no address found'));
            } else if (body.password === undefined) {
                return res.status(400).send(createError('NoPasswordFound', 'Password is required, no password found'));
            }

            req.body.email = body.email.toLowerCase();

            const transactionToken = new TransactionToken()
            transactionToken.createTransactionToken(transactionCode).then((transactionToken: TransactionToken) => {

                if (!transactionToken) {
                    return res.status(400).send(createError('CouldNotCreateToken', 'Could not create token'));
                }

                axios.post(
                    'https://api-' + req.role.name + '/login',
                    {body: req.body},
                    {headers: {'Content-Type': 'application/json', 'trx-auth': transactionToken.token}}).then((res) => {
                    console.log(res);
                }).catch((e) => {
                    console.log(e);
                });

            }).catch((e: Error) => {
                res.status(400).send(mongooseErrors(e));
            });

        });
    }
}
