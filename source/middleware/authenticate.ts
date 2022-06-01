import {isBlackList} from "./utils";
import {createError, mongooseErrors} from "../server/errors/errors";
import {Role} from "../db/role.model";


export function authenticateIpAndRole(req: any, res: any, next: any) {

    const clientIp = req.socket.remoteAddress

    if (isBlackList(clientIp)) {
        return Promise.reject(createError('IpBlackListed', 'The supplied ip is blackListed'));
    }

    Role.findOne({name: req.body.role}).then((role: Role) => {
        if (!role) {
            return Promise.reject(createError('NoRoleFound', 'Given role does not exist'));
        }
        req.role = role;

        next();

    }).catch((e: Error) => {
        return Promise.reject(mongooseErrors(e));
    });
}
