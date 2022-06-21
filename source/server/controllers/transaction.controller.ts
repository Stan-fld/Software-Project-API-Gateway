import {TransactionTokenService} from "../services/transaction-token.service";
import {createError} from "../errors/errors";
import {TransactionService} from "../services/transaction.service";
import {Transaction} from "../models/transaction.model";
import {TransactionToken} from "../models/transaction-token.model";
import logger from "../../middleware/logger";

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
                let error = createError('CouldNotFindTransaction', 'Could not find transaction for given code', 404)

                logger.warn(error);
                return error;
            }
            if (!this.transactionToken) {
                let error = createError('CouldNotCreateTransactionToken', 'Could not create transaction token for given transaction', 404);

                logger.warn(error);
                return error;
            }

            return await this.requestWithReqCat(body);
        } catch (e) {
            if (!e.response) {
                logger.error('Axios error');
                return {data: 'Internal server error', code: 500};
            }

            logger.warn(e.response.data);
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

            logger.info(`Transaction ${this.transaction.desc} executed successfully`);
            return {data: response.data, code: response.status};
        } catch (e) {
            await this.transactionTokenService.deleteTransactionToken(this.transactionToken.token);

            if (!e.response) {
                logger.error('Axios error');
                return {data: 'Internal server error', code: 500};
            }

            logger.warn(e.response.data);
            return {data: e.response.data, code: e.response.status};
        }
    }
}
