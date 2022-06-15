import {AuthenticationService} from "../services/authentication.service";
import {User} from "../models/user.model";

export class AuthenticationController {

    static async createUserAccount(body: any) {
        try {
            const response = await new AuthenticationService().createUser(body);
            const user = User.generateModel(response.data.user);

            return {data: user, code: 201};
        } catch (e) {
            return {data: e.response.data, code: e.response.status};
        }
    }

    static async loginUser(body: { email: string, password: string }) {
        try {
            const response = await new AuthenticationService().loginUser(body.email, body.password);
            const user = User.generateModel(response.data.user);

            return {data: user, code: 200};
        } catch (e) {
            return {data: e.response.data, code: e.response.status};
        }
    }
}
