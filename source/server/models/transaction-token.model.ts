export class TransactionToken {
    id: string;
    token: string;

    static generateModel(json: any): TransactionToken {
        const transactionToken = new TransactionToken();
        transactionToken.id = json.id;
        transactionToken.token = json.token;

        return transactionToken;
    }
}

