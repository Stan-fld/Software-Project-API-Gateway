import mongoose from "mongoose";


const RoleSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        minLength: 2
    },
    desc: {
        type: String,
        required: true,
        minLength: 2
    }
})

export class Role extends mongoose.model('Role', RoleSchema) {
}
