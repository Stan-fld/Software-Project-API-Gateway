import {ObjectId} from "mongodb";
import jwt from "jsonwebtoken";
import {User} from "../db/user.model";
import {roles} from "../middleware/enums";

const userOneId = new ObjectId();
const userTwoId = new ObjectId();
const userThreeId = new ObjectId();

export const SeedUsers = [{
    _id: userOneId.toHexString(),
    firstName: 'Richard',
    lastName: 'Potvin',
    email: 'richard.potvin@test.fr',
    password: 'azertyui',
    birthday: new Date('1999-04-04'),
    roles: [roles.admin, roles.user],
    phone: '+33356588991',
    tokens: [{
        client: 'Android',
        clientId: '123456',
        accessToken: jwt.sign({
            _id: userOneId.toHexString(),
            client: 'Android',
            clientId: '123456',
            iat: Date.now() / 1000
        }, process.env.JWT_SECRET, {expiresIn: '1h'}).toString(),
        refreshToken: jwt.sign({
            _id: userOneId.toHexString(),
            client: 'Android',
            clientId: '123456',
            iat: Date.now() / 1000
        }, process.env.JWT_SECRET, {expiresIn: '7d'}).toString()
    }]
}, {
    _id: userTwoId.toHexString(),
    firstName: 'Grégoire',
    lastName: 'Brisette',
    email: 'greg.brisette@test.fr',
    password: 'azertyui',
    birthday: new Date('1989-05-05'),
    roles: [roles.user],
    phone: '+33350616919',
    tokens: [{
        client: 'iOS',
        clientId: '123456',
        accessToken: jwt.sign({
            _id: userTwoId.toHexString(),
            client: 'iOS',
            clientId: '123456',
            iat: Date.now() / 1000
        }, process.env.JWT_SECRET, {expiresIn: '1h'}).toString(),
        refreshToken: jwt.sign({
            _id: userTwoId.toHexString(),
            client: 'iOS',
            clientId: '123456',
            iat: Date.now() / 1000
        }, process.env.JWT_SECRET, {expiresIn: '7d'}).toString()
    }]
}, {
    _id: userThreeId.toHexString(),
    firstName: 'Alphonse',
    lastName: 'Petit',
    email: 'alphonse.petit@test.fr',
    password: 'azertyui',
    roles: [roles.user],
    birthday: new Date('1968-06-06'),
    phone: '+33287618832',
    tokens: [{
        client: 'iOS',
        clientId: '123456',
        accessToken: jwt.sign({
            _id: userThreeId.toHexString(),
            client: 'iOS',
            clientId: '123456',
            iat: (Date.now() / 1000) - 4000
        }, process.env.JWT_SECRET, {expiresIn: '1h'}).toString(),
        refreshToken: jwt.sign({
            _id: userThreeId.toHexString(),
            client: 'iOS',
            clientId: '123456',
            iat: Date.now() / 1000
        }, process.env.JWT_SECRET, {expiresIn: '7d'}).toString()
    }]
}];

export const PopulateUsers = (done) => {
    User.deleteMany({}).then(() => {

        // required for pre save middleware
        const saveMethods = [];

        for (const user of SeedUsers) {
            saveMethods.push((new User(user)).save());
        }

        return Promise.all(saveMethods);

    }).then(() => done());
}
