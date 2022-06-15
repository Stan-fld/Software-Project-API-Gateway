import {HttpService} from "./http.service";
import {TransactionToken} from "../models/transaction-token.model";
import {Transaction} from "../models/transaction.model";
import {reqCat} from "../../config/enums";
import {createError} from "../errors/errors";


export class TransactionService extends HttpService {

    private readonly url: string;
    private readonly transaction: Transaction
    private readonly body?: any;

    constructor(transaction: Transaction, transactionToken: TransactionToken, body?: any) {
        super(transactionToken.token);
        this.url = `${transaction.service.domain} / ${transaction.code}`;
        this.transaction = transaction;
        this.body = body || null;
    }

    redirectionWithTransactionToken() {
        switch (this.transaction.reqCat) {
            case reqCat.get:
                return this.getWithTransactionToken();

            case reqCat.put:
                return this.putWithTransactionToken();

            case reqCat.patch:
                return this.patchWithTransactionToken();

            case reqCat.post:
                return this.postWithTransactionToken();

            case reqCat.delete:
                return this.deleteWithTransactionToken();

            default :
                return Promise.reject(createError('InvalidReqCat', 'Invalid request category', 400));
        }
    }


    getWithTransactionToken(): Promise<any> {
        return this.http.get(this.url);
    }

    putWithTransactionToken(): Promise<any> {
        return this.http.put(this.url, this.body)
    }

    patchWithTransactionToken(): Promise<any> {
        return this.http.patch(this.url, this.body);
    }

    postWithTransactionToken(): Promise<any> {
        return this.http.post(this.url, this.body);
    }

    deleteWithTransactionToken(): Promise<any> {
        return this.http.delete(this.url + '/' + this.body.id);
    }

    /*
        deleteWithTransactionToken(): Promise<any> {
            return this.http.delete(this.url + '/' + this.body.id).then((axiosRes) => {

                return this.transactionToken.destroy().then(() => {
                    return axiosRes.data;
                });

            }).catch((e) => {

                return this.transactionToken.destroy().then(() => {
                    return Promise.reject(e.response.data);
                });

            });
        }
     */

}
