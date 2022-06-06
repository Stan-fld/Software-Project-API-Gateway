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

    createTransactionToken(transactionCode: string) {

        return Transaction.findOne({code: transactionCode}).then((transaction: Transaction) => {

            if (!transaction) {
                return Promise.reject(createError('CouldNotFindTransaction', 'Could not find transaction for given code'));
            }

            return Role.findOne({_id: transaction.role}).then((role: Role) => {

                if (!role) {
                    return Promise.reject(createError('CouldNotFindRole', 'Could not find transaction role for given code'));
                }

                this.token = jwt.sign({
                    roleId: transaction.role,
                    transactionId: transaction._id,
                    iat: Date.now() / 1000
                }, process.env.JWT_SECRET!, {expiresIn: '2h'}).toString();

                return this.save().then((transactionToken: TransactionToken) => {
                    return {transactionToken, role};
                });
            })

        }).catch((e) => {
            return Promise.reject(mongooseErrors(e))
        })

    }
}

