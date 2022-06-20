import {HttpService} from "./http.service";
import {TransactionToken} from "../models/transaction-token.model";
import {Transaction} from "../models/transaction.model";

export class TransactionTokenService extends HttpService {


    constructor(userToken: string) {
        super(null, userToken);
    }

    /**
     * Service who request auth service API for create a new transaction token
     * @param transactionCode
     */
    createTransactionToken(transactionCode: string,) {
        return this.http.get<{ transaction: Transaction, transactionToken: TransactionToken }>(
            'auth/createTransactionToken/' + transactionCode
        );
    }

    /**
     * Service who request auth service API for delete a transaction token
     * @param transactionToken
     */
    deleteTransactionToken(transactionToken: string) {
        return this.http.delete(
            `auth/deleteTransactionToken/${transactionToken}`
        );
    }
}
