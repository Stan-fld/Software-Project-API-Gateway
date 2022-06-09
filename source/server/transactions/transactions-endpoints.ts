import {Express} from "express";
import {authenticateIp} from "../../middleware/authenticate";
import {TransactionService} from "../../service/transaction-service";


export class TransactionEndpoints {

    static newTransaction(app: Express) {
        app.post('/transaction/:transactionCode', authenticateIp, (req: any, res) => {

            const transactionCode = req.params.transactionCode;

            new TransactionService(transactionCode, req.header('x-auth'), req.body).redirectTransaction().then((data) => {
                return res.status(201).send(data);
            }).catch((e) => {
                return res.send(e);
            })
        })
    }
}
