import {TransactionTokenService} from "../service/transaction-token.service";
import {createError} from "../server/errors/errors";
import {TransactionService} from "../service/transaction.service";
import {Transaction} from "../interface/transaction.interface";
import {TransactionToken} from "../interface/transaction-token.interface";

export class TransactionController {

    static async redirectTransaction(transactionCode: string, userToken: string, body?: any) {
        try {
            const transactionTokenService = new TransactionTokenService(userToken);
            const response = await transactionTokenService.createTransactionToken(transactionCode);

            if (!response.data.transaction) {
                return createError('CouldNotFindTransaction', 'Could not find transaction for given code', 404);
            }
            if (!response.data.transactionToken) {
                return createError('CouldNotCreateTransactionToken', 'Could not create transaction token for given transaction', 404);
            }

            return await this.requestWithReqCat(transactionTokenService, response.data.transaction, response.data.transactionToken, body);
        } catch (e) {
            return {data: e.response.data, code: e.response.status};
        }
    }

    private static async requestWithReqCat(transactionTokenService: TransactionTokenService, transaction: Transaction, transactionToken: TransactionToken, body?: any) {
        try {
            const response = await new TransactionService(transaction, transactionToken, body).redirectionWithTransactionToken();
            await transactionTokenService.deleteTransactionToken(transactionToken.token);

            return {data: response.data, code: response.status};
        } catch (e) {
            await transactionTokenService.deleteTransactionToken(transactionToken.token);

            return {data: e.response.data, code: e.response.status};
        }
    }
}
