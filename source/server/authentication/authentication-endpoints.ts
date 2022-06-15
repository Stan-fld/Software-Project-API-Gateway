import {Express, Response} from "express";
import {AuthenticationController} from "../../controller/authentication.controller";
import {authenticateIp} from "../../middleware/authenticate";

export class AuthenticationEndpoints {
    static signUp(app: Express) {

        app.post('/user/register', authenticateIp, async (req: any, res: Response) => {

            const response = await AuthenticationController.createUserAccount(req.body)

            res.status(response.code).send(response.data);

        });
    }

    static signIn(app: Express) {

        app.post('/user/login', authenticateIp, async (req: any, res) => {

            const response = await AuthenticationController.loginUser(req.body);

            res.status(response.code).send(response.data);

        });
    }
}
