export class TransactionToken {
    token: string;

    static generateModel(json: any): TransactionToken {
        const transactionToken = new TransactionToken();
        transactionToken.token = json.token;

        return transactionToken;
    }
}

