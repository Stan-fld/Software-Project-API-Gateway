import {Role} from "./role.interface";
import {Service} from "./service.interface";

export interface Transaction {
    id: string;
    code: string;
    reqCat: string;
    desc: string;
    roleId: string;
    role: Role;
    serviceId: string;
    service: Service;
}
