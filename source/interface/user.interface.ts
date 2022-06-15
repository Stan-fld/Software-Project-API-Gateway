import {Role} from "./role.interface";

export interface User {
    id?: string;
    firstName: string;
    lastName: string;
    email: string;
    address: string;
    phone: string;
    password: string;
    roleId: string;
    role: Role;
    accessToken?: string;
    refreshToken?: string;
}
