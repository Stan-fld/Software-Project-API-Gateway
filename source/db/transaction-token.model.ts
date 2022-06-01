import jwt from "jsonwebtoken";
import mongoose from "mongoose";
import {Transaction} from "./transaction.model";
import {createError, mongooseErrors} from "../server/errors/errors";
import {Role} from "./role.model";


const transactionTokenSchema = new mongoose.Schema({
    token: {
        type: String,
        required: true
    }
}, {timestamps: true})

export class TransactionToken extends mongoose.model('TransactionToken', transactionTokenSchema) {

    createTransactionToken(role: Role, transactionCode: string) {

        return Transaction.findOne({code: transactionCode}).then((transaction: Transaction) => {


            if (!transaction) {
                return Promise.reject(createError('CouldNotFindTransaction', 'Could not find transaction for given code'));
            }

            this.token = jwt.sign({
                roleId: role._id,
                transactionId: transaction._id,
                iat: Date.now() / 1000
            }, process.env.JWT_SECRET!, {expiresIn: '2h'}).toString();

            return this.save().then((trxTk: TransactionToken) => {
                return trxTk
            });

        }).catch((e) => {
            return Promise.reject(mongooseErrors(e))
        })

    }
}

