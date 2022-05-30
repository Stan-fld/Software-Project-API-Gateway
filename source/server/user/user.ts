import {Express} from "express";
import {createError, mongooseErrors} from "../errors/errors";
import {User} from "../../db/user.model";
import {authenticateUser} from "../../middleware/authenticate-user";
import {bodyPick} from "../../middleware/utils";

export class UserEndpoints {
    static updateUser(app: Express) {

        app.patch('/user/me', authenticateUser, (req: any, res) => {

            const body = bodyPick(['firstName', 'lastName', 'phone'], req.body);

            User.findOneAndUpdate({
                _id: req.user._id
            }, {
                $set: body
            }, {
                new: true
            }).then((user) => {
                if (!user) {
                    return Promise.reject(createError('CouldNotFindUser', 'Could not find user for id '));
                }

                res.send({data: user});
            }).catch((e) => {
                res.status(400).send(mongooseErrors(e));
            });
        });
    }

    static changeUserPassword(app: Express) {
        app.patch('/user/me/password', authenticateUser, (req: any, res) => {
            const password = req.body.password;
            const newPassword = req.body.newPassword;

            if (!password) {
                return res.status(400).send(createError('PasswordIsRequired', 'User password is required'));
            }

            req.user.verifyPassword(password).then(() => {
                req.user.password = newPassword;
                return req.user.save();
            }).then((u) => {
                res.send({data: u});
            }).catch((e) => {
                res.status(400).send(mongooseErrors(e));
            });
        });
    }
}
