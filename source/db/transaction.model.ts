import mongoose from "mongoose";


const TransactionSchema = new mongoose.Schema({
    code: {
        type: String,
        required: true,
        minLength: 1
    },
    desc: {
        type: String,
        required: true
    },
    role: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Role',
        required: true
    },
})

export class Transaction extends mongoose.model('Transaction', TransactionSchema) {
}
