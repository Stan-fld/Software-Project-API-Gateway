import {Express} from "express";
import {TransactionToken} from "../../db/transaction-token.model";
import axios from "axios";
import {mongooseErrors} from "../errors/errors";
import {authenticateIp} from "../../middleware/authenticate";


export class TransactionEndpoints {

    static newTransaction(app: Express) {
        app.post('/transaction/:transactionCode', authenticateIp, (req: any, res) => {

            const transactionCode = req.params.transactionCode;

            const transactionToken = new TransactionToken()
            transactionToken.createTransactionToken(transactionCode).then((transactionToken: TransactionToken) => {

                axios.post(
                    'https://api-' + req.role.name + '/' + transactionCode,
                    {req},
                    {headers: {'Content-Type': 'application/json', 'trx-auth': transactionToken.token}}).then((res) => {
                    console.log(res);
                }).catch((e) => {
                    console.log(e);
                });

            }).catch((e: Error) => {
                res.status(400).send(mongooseErrors(e));
            });
        })

    }
}
