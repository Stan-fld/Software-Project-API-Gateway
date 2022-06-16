import {Role} from "./role.model";
import {Service} from "./service.model";

export class Transaction {
    id: string;
    code: string;
    reqCat: string;
    name: string;
    desc: string;
    roleId: string;
    role: Role;
    serviceId: string;
    service: Service;

    static generateModel(json: any): Transaction {
        const transaction = new Transaction();
        transaction.id = json.id;
        transaction.code = json.code;
        transaction.reqCat = json.reqCat;
        transaction.name = json.name;
        transaction.desc = json.desc;
        transaction.roleId = json.roleId;
        transaction.role = Role.generateModel(json.role);
        transaction.serviceId = json.serviceId;
        transaction.service = Service.generateModel(json.service);

        return transaction;
    }
}
