import {HttpService} from "./http.service";
import {TransactionToken} from "../models/transaction-token.model";
import {Transaction} from "../models/transaction.model";

export class TransactionTokenService extends HttpService {


    constructor(userToken: string) {
        super(null, userToken);
    }

    createTransactionToken(transactionCode: string,) {
        return this.http.post<{ transaction: Transaction, transactionToken: TransactionToken }>(
            'auth/createTransactionToken',
            {transactionCode: transactionCode});
    }

    deleteTransactionToken(transactionToken: string) {
        return this.http(
            `auth/deleteTransactionToken/${transactionToken}`)
    }
}
