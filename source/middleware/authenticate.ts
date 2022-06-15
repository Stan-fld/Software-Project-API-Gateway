import {isBlackList} from "./utils";
import {createError} from "../server/errors/errors";


export function authenticateIp(req: any, res: any, next: any) {

    const clientIp = req.socket.remoteAddress

    if (isBlackList(clientIp)) {
        return res.status(403).send(createError('IpBlackListed', 'The supplied ip is blackListed', 403));
    }

    next();
}
