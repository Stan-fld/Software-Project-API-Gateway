import {AuthenticationService} from "../services/authentication.service";
import {User} from "../models/user.model";
import logger from "../../middleware/logger";

export class AuthenticationController {

    /**
     * Controller method to register a new user
     * @param body
     */
    static async createUserAccount(body: any) {
        try {
            const response = await new AuthenticationService().createUser(body);
            const user = User.generateModel(response.data.user);

            logger.info('User created successfully');
            return {data: user, code: 201};
        } catch (e) {
            if (!e.response) {
                logger.error('Axios error');
                return {data: 'Internal server error', code: 500};
            }

            logger.warn(e.response.data[0].name + ': ' + e.response.data[0].message);
            return {data: e.response.data, code: e.response.status};
        }
    }

    /**
     * Controller method to login a user
     * @param body
     */
    static async loginUser(body: { email: string, password: string }) {
        try {
            const response = await new AuthenticationService().loginUser(body.email, body.password);
            const user = User.generateModel(response.data.user);
            logger.info('User created successfully');

            return {data: user, code: 200};
        } catch (e) {
            if (!e.response) {
                logger.error('Axios error');
                return {data: 'Internal server error', code: 500};
            }
            logger.warn(e.response.data[0].name + ': ' + e.response.data[0].message);
            return {data: e.response.data, code: e.response.status};
        }
    }
}
