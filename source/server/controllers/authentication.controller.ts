import {AuthenticationService} from "../services/authentication.service";
import {User} from "../models/user.model";

export class AuthenticationController {

    /**
     * Controller method to register a new user
     * @param body
     */
    static async createUserAccount(body: any) {
        try {
            const response = await new AuthenticationService().createUser(body);
            const user = User.generateModel(response.data.user);

            return {data: user, code: 201};
        } catch (e) {
            if (!e.response) {
                return {data: 'Internal server error', code: 500};
            }
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

            return {data: user, code: 200};
        } catch (e) {
            if (!e.response) {
                return {data: 'Internal server error', code: 500};
            }
            return {data: e.response.data, code: e.response.status};
        }
    }
}
