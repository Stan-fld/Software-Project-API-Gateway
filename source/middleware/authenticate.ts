import {isBlackList} from "./utils";
import {createError, mongooseErrors} from "../server/errors/errors";
import {Role} from "../db/role.model";


export function authenticateIp(req: any, res: any, next: any) {

    const clientIp = req.socket.remoteAddress

    if (isBlackList(clientIp)) {
        return Promise.reject(createError('IpBlackListed', 'The supplied ip is blackListed'));
    }
}
