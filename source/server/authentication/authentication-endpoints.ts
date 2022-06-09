import {Express, Response} from "express";
import {authenticateIp} from "../../middleware/authenticate";
import {AuthenticationService} from "../../service/authentication-service";

export class AuthenticationEndpoints {
    static signUp(app: Express) {

        app.post('/register/:transactionCode', authenticateIp, (req: any, res: Response) => {

            const transactionCode = req.params.transactionCode;

            AuthenticationService.postWithoutAuth(transactionCode, req.body).then((data) => {
                return res.status(201).send(data);
            }).catch((e) => {
                return res.status(400).send(e);
            });

        });
    }

    static signIn(app: Express) {

        app.post('/login/:transactionCode', authenticateIp, (req: any, res) => {

            const transactionCode = req.params.transactionCode;

            AuthenticationService.postWithoutAuth(transactionCode, req.body).then((data) => {
                return res.status(200).send(data);
            }).catch((e) => {
                return res.status(400).send(e);
            });

        });
    }
}
