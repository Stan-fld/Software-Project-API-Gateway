import {Express} from "express";
import {createError, mongooseErrors} from "../errors/errors";
import {bodyPick} from "../../middleware/utils";
import axios from 'axios';
import {TransactionToken} from "../../db/transaction-token.model";
import {authenticateIp} from "../../middleware/authenticate";

export class Authentication {
    static signUp(app: Express) {

        app.post('/register/:transactionCode', authenticateIp, (req: any, res) => {

            const transactionCode = req.params.transactionCode;
            const clientInfo = bodyPick(['client', 'clientId'], req.body.clientInfo);

            if (clientInfo.client === undefined) {
                return res.status(400).send(createError('NoClientFound', 'Client required, no client found'));
            } else if (clientInfo.clientId === undefined) {
                return res.status(400).send(createError('NoClientIdFound', 'Client Id required, no id found'));
            }

            const transactionToken = new TransactionToken();
            transactionToken.createTransactionToken(transactionCode).then(({transactionToken, role}) => {

                if (!transactionToken) {
                    return res.status(400).send(createError('CouldNotCreateToken', 'Could not create token'));
                }

                axios.post(
                    //'https://api-' + req.role.name + '/register',
                    'http://localhost:8000/' + role.name + '/register',
                    req.body,
                    {
                        headers: {
                            'Content-Type': 'application/json',
                            'trx-auth': transactionToken.token
                        }
                    }).then((axiosRes) => {

                    transactionToken.deleteOne(transactionToken).then(() => {
                        return res.status(201).send(axiosRes.data);
                    });

                }).catch((e) => {

                    transactionToken.deleteOne(transactionToken).then(() => {
                        return res.status(e.response.status).send(e.response.data);
                    });

                });

            }).catch((e: Error) => {
                return res.status(400).send(mongooseErrors(e));
            });

        });
    }

    static signIn(app: Express) {

        app.post('/login/:transactionCode', authenticateIp, (req: any, res) => {

            const transactionCode = req.params.transactionCode;
            const clientInfo = bodyPick(['client', 'clientId'], req.body);

            if (clientInfo.client === undefined) {
                return res.status(400).send(createError('NoClientFound', 'Client required, no client found'));
            } else if (clientInfo.clientId === undefined) {
                return res.status(400).send(createError('NoClientIdFound', 'Client Id required, no id found'));
            }

            const transactionToken = new TransactionToken()
            transactionToken.createTransactionToken(transactionCode).then(({transactionToken, role}) => {

                if (!transactionToken) {
                    return res.status(400).send(createError('CouldNotCreateToken', 'Could not create token'));
                }

                axios.post(
                    //'https://api-' + req.role.name + '/login',
                    'http://localhost:8000/' + role.name + '/login',
                    req.body,
                    {
                        headers: {
                            'Content-Type': 'application/json',
                            'trx-auth': transactionToken.token
                        }
                    }).then((axiosRes) => {

                    transactionToken.deleteOne(transactionToken).then(() => {
                        return res.status(201).send(axiosRes.data);
                    });

                }).catch((e) => {

                    transactionToken.deleteOne(transactionToken).then(() => {
                        return res.status(e.response.status).send(e.response.data);
                    });

                });

            }).catch((e: Error) => {

                return res.status(400).send(mongooseErrors(e));

            });

        });
    }
}
