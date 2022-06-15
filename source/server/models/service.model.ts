export class Service {
    id: string;
    domain: string;

    static generateModel(json: any): Service {
        const service = new Service();
        service.id = json.id;
        service.domain = json.domain;

        return service;
    }
}


