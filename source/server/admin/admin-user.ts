import {Express} from "express";
import {User} from "../../db/user.model";
import {createError, mongooseErrors} from "../errors/errors";
import {authenticateAdmin} from "../../middleware/authenticate-admin";
import {ObjectId} from "mongodb";


export class AdminUsersEndpoints {
    static fetchUsers(app: Express) {

        app.get('/admin/users', authenticateAdmin, (req, res) => {

            User.find({}).then((users) => {
                if (!users) {
                    return Promise.reject(createError('CouldNotFindUsers', 'Could not find users'));
                }

                res.send({data: users});
            }).catch((e) => {
                res.status(400).send(mongooseErrors(e));
            });

        });
    }

    static deleteUser(app: Express) {

        app.post('/admin/:userId/deleteUser', authenticateAdmin, (req: any, res) => {

            const password = req.body.password;

            if (!ObjectId.isValid(req.params.userId)) {
                return res.status(404).send(createError('UserIdWrongOrUndefined', 'User id to delete is wrong or undefined'));
            }

            if (!password) {
                return res.status(400).send(createError('PasswordIsRequired', 'User password is required'));
            }

            req.user.verifyPassword(password).then(() => {
                return User.deleteOne({_id: req.params.userId})
            }).then((u) => {
                if (!u) {
                    return Promise.reject(createError('CouldNotDeleteUser', 'Could not delete user'));
                }
                res.send({data: true});
            }).catch((e) => {
                res.status(400).send(mongooseErrors(e));
            });
        });
    }
}
