import {HttpService} from "./http.service";
import {User} from "../interface/user.interface";

export class AuthenticationService extends HttpService {

    constructor() {
        super();
    }

    createUser(user:any) {
        return this.http.post<{ user: User }>('auth/register', user);
    }

    loginUser(email:string, password:string) {
        return this.http.post<{ user: User }>('auth/login', {email: email, password: password});
    }

}
