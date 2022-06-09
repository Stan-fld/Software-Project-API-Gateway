import axios from "axios";
import Role from "../db/role.model";
import Transaction from "../db/transaction.model";
import TransactionToken from "../db/transaction-token.model";
import {createError} from "../server/errors/errors";
import {reqCat} from "../config/enums";


export class TransactionService {

    private readonly url: string = 'http://localhost:8000/';

    private transactionCode: string;
    private readonly userToken: any;
    private body?: any;
    private axiosHeaders: any;
    private transaction: Transaction;
    private transactionToken: TransactionToken;
    private role: Role;

    constructor(transactionCode: string, userToken: any, body?: any) {
        this.transactionCode = transactionCode;
        this.userToken = userToken;
        this.body = body;
        this.axiosHeaders = {
            'Content-Type': 'application/json',
            'trx-auth': this.transactionToken.token,
            'x-auth': this.userToken
        };
        this.url += this.role.name + '/' + this.transaction.code;
    }

    redirectTransaction(): Promise<any> {
        return new TransactionToken().createTransactionToken(this.transactionCode).then((data) => {
            this.transaction = data.transaction;
            this.transactionToken = data.transactionToken;
            this.role = data.role;

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

                default:
                    return Promise.reject(createError('ReqCatNotSupported', 'This request category is not supported.'));
            }
        }).catch((e) => {
            return Promise.reject(e);
        });
    }

    getWithTransactionToken(): Promise<any> {
        return axios.get(
            this.url,
            {
                headers: this.axiosHeaders
            }).then((axiosRes) => {

            return this.transactionToken.destroy().then(() => {
                return axiosRes.data;
            });

        }).catch((e) => {

            return this.transactionToken.destroy().then(() => {
                return Promise.reject(e.response.data);
            });

        });
    }

    putWithTransactionToken(): Promise<any> {
        return axios.put(
            this.url,
            this.body,
            {
                headers: this.axiosHeaders
            }).then((axiosRes) => {

            return this.transactionToken.destroy().then(() => {
                return axiosRes.data;
            });

        }).catch((e) => {

            return this.transactionToken.destroy().then(() => {
                return Promise.reject(e.response.data);
            });

        });
    }

    patchWithTransactionToken(): Promise<any> {
        return axios.patch(
            this.url,
            this.body,
            {
                headers: this.axiosHeaders
            }).then((axiosRes) => {

            return this.transactionToken.destroy().then(() => {
                return axiosRes.data;
            });

        }).catch((e) => {

            return this.transactionToken.destroy().then(() => {
                return Promise.reject(e.response.data);
            });

        });
    }

    postWithTransactionToken(): Promise<any> {
        return axios.post(
            this.url,
            this.body,
            {
                headers: this.axiosHeaders
            }).then((axiosRes) => {

            return this.transactionToken.destroy().then(() => {
                return axiosRes.data;
            });

        }).catch((e) => {

            return this.transactionToken.destroy().then(() => {
                return Promise.reject(e.response.data);
            });

        });
    }

    deleteWithTransactionToken(): Promise<any> {
        return axios.delete(
            this.url,
            {
                headers: this.axiosHeaders
            }).then((axiosRes) => {

            return this.transactionToken.destroy().then(() => {
                return axiosRes.data;
            });

        }).catch((e) => {

            return this.transactionToken.destroy().then(() => {
                return Promise.reject(e.response.data);
            });

        });
    }

}
