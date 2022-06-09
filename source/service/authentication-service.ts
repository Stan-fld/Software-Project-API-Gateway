import axios from "axios";
import TransactionToken from "../db/transaction-token.model";


export class AuthenticationService {

    static postWithoutAuth(transactionCode: string, body: any): Promise<any> {

        return new TransactionToken().createTransactionToken(transactionCode).then((data) => {

            const axiosHeaders = {'Content-Type': 'application/json', 'trx-auth': data.transactionToken.token};
            return axios.post(
                'http://localhost:8000/' + data.role.name + '/' + data.transaction.code,
                body,
                {
                    headers: axiosHeaders
                }).then((axiosRes) => {

                return data.transactionToken.destroy().then(() => {
                    return axiosRes.data;
                });

            }).catch((e) => {

                return data.transactionToken.destroy().then(() => {
                    return Promise.reject(e.response.data);
                });

            });

        }).catch((e) => {
            return Promise.reject(e);
        });
    }

}
