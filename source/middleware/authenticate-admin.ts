import {User} from '../db/user.model';
import {authenticationFailed, mongooseErrors} from "../server/errors/errors";
import {isTheRole} from "./utils";
import {roles} from "./enums";

export function authenticateAdmin(req: any, res: any, next: any) {

    const token = req.header('x-auth');

    User.findWithAccessToken(token).then((user: User) => {

        if (!user) {
            return Promise.reject(authenticationFailed('No user found'));
        } else if (!isTheRole(user, roles.admin)) {
            return Promise.reject(authenticationFailed('An admin account is required to access these endpoints, access is denied.'));
        }

        req.user = user;
        req.token = token;

        next();

    }).catch((e) => {
        res.status(401).send(mongooseErrors(e));
    });
}
