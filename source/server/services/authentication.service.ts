import {HttpService} from "./http.service";
import {User} from "../models/user.model";

export class AuthenticationService extends HttpService {

    constructor(userToken?: string) {
        super(null, userToken);
    }

    /**
     * Service to register user
     * @param user
     */
    createUser(user: any) {
        return this.http.post<{ user: User }>('auth/register', user);
    }

    /**
     * Service to login user
     * @param email
     * @param password
     */
    loginUser(email: string, password: string) {
        return this.http.post<{ user: User }>('auth/login', {email: email, password: password});
    }

    /**
     * Service to logout a user
     */
    logoutUser() {
        return this.http.get<{ success: boolean }>('auth/logout');
    }

}
