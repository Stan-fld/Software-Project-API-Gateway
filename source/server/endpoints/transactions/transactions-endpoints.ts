import {Express} from "express";
import {authenticateIp} from "../../../middleware/authenticate";
import {TransactionController} from "../../controllers/transaction.controller";


export class TransactionEndpoints {

    /**
     * Endpoint to request service with transaction code
     * @param app
     */
    static transaction(app: Express) {
        app.post('/transaction/:transactionCode', authenticateIp, async (req: any, res) => {
            const transactionCode = req.params.transactionCode;

            const response = await TransactionController.redirectTransaction(transactionCode, req.header('x-auth'), req.body);

            res.status(response.code).send({data: response.data});

        });
    }
}
