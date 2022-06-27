import {Express, Response} from "express";
import {AuthenticationController} from "../../controllers/authentication.controller";
import {authenticateIp} from "../../../middleware/authenticate";

export class AuthenticationEndpoints {

    /**
     * Endpoint to register a user
     * @param app
     */
    static signUp(app: Express) {

        app.post('/user/register', authenticateIp, async (req: any, res: Response) => {

            const response = await AuthenticationController.createUserAccount(req.body)

            res.status(response.code).send({data: response.data});

        });
    }

    /**
     * Endpoint to login a user
     * @param app
     */
    static signIn(app: Express) {

        app.post('/user/login', authenticateIp, async (req: any, res) => {

            const response = await AuthenticationController.loginUser(req.body);

            res.status(response.code).send({data: response.data});

        });
    }

    /**
     * Endpoint to logout a user
     * @param app
     */
    static signOut(app: Express) {

        app.get('/user/logout', authenticateIp, async (req: any, res) => {

            const response = await AuthenticationController.logoutUser(req.header('x-auth'));

            res.status(response.code).send({data: response.data});

        });
    }
}
