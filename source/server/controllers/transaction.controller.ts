import {TransactionTokenService} from "../services/transaction-token.service";
import {createError} from "../errors/errors";
import {TransactionService} from "../services/transaction.service";
import {Transaction} from "../models/transaction.model";
import {TransactionToken} from "../models/transaction-token.model";

export class TransactionController {

    private static transaction: Transaction;
    private static transactionToken: TransactionToken;
    private static transactionTokenService: TransactionTokenService;

    /**
     * Controller to redirect transaction request
     * @param transactionCode
     * @param userToken
     * @param body
     */
    static async redirectTransaction(transactionCode: string, userToken: string, body?: any) {
        try {
            this.transactionTokenService = new TransactionTokenService(userToken);
            const response = await this.transactionTokenService.createTransactionToken(transactionCode);

            this.transaction = Transaction.generateModel(response.data.transaction);
            this.transactionToken = TransactionToken.generateModel(response.data.transactionToken);

            if (!this.transaction) {
                return createError('CouldNotFindTransaction', 'Could not find transaction for given code', 404);
            }
            if (!this.transactionToken) {
                return createError('CouldNotCreateTransactionToken', 'Could not create transaction token for given transaction', 404);
            }

            return await this.requestWithReqCat(body);
        } catch (e) {
            if (!e.response) {
                return {data: 'Internal server error', code: 500};
            }

            return {data: e.response.data, code: e.response.status};
        }
    }

    /**
     * Controller to execute request with transaction code
     * @param body
     * @private
     */
    private static async requestWithReqCat(body?: any) {
        try {
            const response = await new TransactionService(this.transaction, this.transactionToken, body).redirectionWithTransactionToken();
            await this.transactionTokenService.deleteTransactionToken(this.transactionToken.token);

            return {data: response.data, code: response.status};
        } catch (e) {
            await this.transactionTokenService.deleteTransactionToken(this.transactionToken.token);

            if (!e.response) {
                return {data: 'Internal server error', code: 500};
            }

            return {data: e.response.data, code: e.response.status};
        }
    }
}
