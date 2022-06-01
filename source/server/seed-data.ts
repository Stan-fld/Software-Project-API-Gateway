import {ObjectId} from "mongodb";
import {roles} from "../config/enums";
import {Role} from "../db/role.model";
import {Transaction} from "../db/transaction.model";


const roleOneId = new ObjectId();
const roleTwoId = new ObjectId();
const roleThreeId = new ObjectId();
const roleFourId = new ObjectId();
const roleFiveId = new ObjectId();
const roleSixId = new ObjectId();
const roleSevenId = new ObjectId();

export const SeedRoles = [{
    _id: roleOneId.toHexString(),
    name: roles.deliverer,
    desc: 'Deliverer'
}, {
    _id: roleTwoId.toHexString(),
    name: roles.restau,
    desc: 'Restaurant'
}, {
    _id: roleThreeId.toHexString(),
    name: roles.client,
    desc: 'Client'
}, {
    _id: roleFourId.toHexString(),
    name: roles.apiUser,
    desc: 'API user'
}, {
    _id: roleFiveId.toHexString(),
    name: roles.extDev,
    desc: 'External developer'
}, {
    _id: roleSixId.toHexString(),
    name: roles.commServ,
    desc: 'Commercial service'
}, {
    _id: roleSevenId.toHexString(),
    name: roles.techServ,
    desc: 'Technical service'
},
]

export const PopulateRoles = (done) => {
    Role.deleteMany({}).then(() => {

        // required for pre save middleware
        const saveMethods = [];

        for (const role of SeedRoles) {
            saveMethods.push((new Role(role)).save());
        }

        return Promise.all(saveMethods);

    }).then(() => done());
}


const transactionOneId = new ObjectId();
const transactionTwoId = new ObjectId();

export const SeedTransactions = [{
    _id: transactionOneId.toHexString(),
    code: 'CR',
    desc: 'Create restaurant',
    role: roleTwoId.toHexString(),
}, {
    _id: transactionTwoId.toHexString(),
    code: 'CCL',
    desc: 'Create client',
    role: roleThreeId.toHexString(),
}]

export const PopulateTransactions = (done) => {
    Transaction.deleteMany({}).then(() => {

        // required for pre save middleware
        const saveMethods = [];

        for (const transaction of SeedTransactions) {
            saveMethods.push((new Transaction(transaction)).save());
        }

        return Promise.all(saveMethods);

    }).then(() => done());
}
