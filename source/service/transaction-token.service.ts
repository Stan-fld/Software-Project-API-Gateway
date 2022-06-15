import {HttpService} from "./http.service";
import {TransactionToken} from "../interface/transaction-token.interface";
import {Transaction} from "../interface/transaction.interface";

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
