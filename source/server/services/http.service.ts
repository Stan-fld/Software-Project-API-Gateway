import axios, {AxiosInstance} from "axios";

export abstract class HttpService {

    http: AxiosInstance

    protected constructor(transactionToken?: string, userToken?: string) {
        this.http = axios.create({
            baseURL:'https://',
            headers: {
                'Content-Type': 'application/json',
                'trx-auth': transactionToken || null,
                'x-auth': userToken ||null
            }
        });
    }
}
