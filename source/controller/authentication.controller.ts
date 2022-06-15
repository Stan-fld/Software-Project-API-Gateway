import {AuthenticationService} from "../service/authentication.service";

export class AuthenticationController {

    static async createUserAccount(body: any) {
        try {
            const {data: {user}} = await new AuthenticationService().createUser(body);

            return {data: user, code: 201};
        } catch (e) {
            return {data: e.response.data, code: e.response.status};
        }
    }

    static async loginUser(body: { email: string, password: string }) {
        try {
            const {data: {user}} = await new AuthenticationService().loginUser(body.email, body.password);

            return {data: user, code: 200};
        } catch (e) {
            return {data: e.response.data, code: e.response.status};
        }
    }
}
