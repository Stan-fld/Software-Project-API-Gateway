import {Role} from "./role.model";
import {Service} from "./service.model";

export class Transaction {
    id: string;
    code: string;
    method: string;
    name: string;
    desc: string;
    role: Role;
    service: Service;

    static generateModel(json: any): Transaction {
        const transaction = new Transaction();
        transaction.id = json.id;
        transaction.code = json.code;
        transaction.method = json.method;
        transaction.name = json.name;
        transaction.desc = json.desc;
        transaction.role = Role.generateModel(json.role);
        transaction.service = Service.generateModel(json.service);

        return transaction;
    }
}
