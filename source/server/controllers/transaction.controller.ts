import {TransactionTokenService} from "../services/transaction-token.service";
import {createError} from "../errors/errors";
import {TransactionService} from "../services/transaction.service";
import {Transaction} from "../models/transaction.model";
import {TransactionToken} from "../models/transaction-token.model";
import logger from "../../middleware/logger";

export class TransactionController {

    /**
     * Controller to redirect transaction request
     * @param transactionCode
     * @param userToken
     * @param body
     */
    static async redirectTransaction(transactionCode: string, userToken: string, body?: any) {
        try {
            const transactionTokenService: TransactionTokenService = new TransactionTokenService(userToken);
            const response = await transactionTokenService.createTransactionToken(transactionCode);

            const transaction: Transaction = Transaction.generateModel(response.data.transaction);
            const transactionToken: TransactionToken = TransactionToken.generateModel(response.data.transactionToken);

            if (!transaction) {
                let error = createError('CouldNotFindTransaction', 'Could not find transaction for given code', 404)

                logger.warn(error);
                return error;
            }
            if (!transactionToken) {
                let error = createError('CouldNotCreateTransactionToken', 'Could not create transaction token for given transaction', 404);

                logger.warn(error);
                return error;
            }

            return await this.requestWithReqCat(transaction, transactionToken, transactionTokenService, body);
        } catch (e) {
            if (!e.response) {
                logger.error('Axios error');
                return {data: 'Internal server error', code: 500};
            }

            logger.warn(e.response.data[0].name + ': ' + e.response.data[0].message);
            return {data: e.response.data, code: e.response.status};
        }
    }

    /**
     * Controller to execute request with transaction code
     * @param transaction
     * @param transactionToken
     * @param transactionTokenService
     * @param body
     * @private
     */
    private static async requestWithReqCat(transaction: Transaction, transactionToken: TransactionToken, transactionTokenService: TransactionTokenService, body?: any) {
        try {
            const response = await new TransactionService(transaction, transactionToken, body).redirectionWithTransactionToken();
            await transactionTokenService.deleteTransactionToken(transactionToken.token);

            logger.info(`Transaction ${transaction.desc} executed successfully`);
            return {data: response.data, code: response.status};
        } catch (e) {
            await transactionTokenService.deleteTransactionToken(transactionToken.token);
            if (!e.response) {
                logger.error('Axios error');
                return {data: 'Internal server error', code: 500};
            }

            logger.warn(`Transaction ${transaction.desc} - ${e.response.data[0].name}: ${e.response.data[0].message}`);
            return {data: e.response.data, code: e.response.status};
        }
    }
}
