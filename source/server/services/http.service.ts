import axios, {AxiosInstance} from "axios";

export abstract class HttpService {

    http: AxiosInstance

    /**
     * HttpService constructor
     * @param transactionToken
     * @param userToken
     * @protected
     */
    protected constructor(transactionToken?: string, userToken?: string) {
        this.http = axios.create({
            //baseURL:'https://',
            baseURL:'http://localhost:8000/',
            headers: {
                'Content-Type': 'application/json',
                'trx-auth': transactionToken || null,
                'x-auth': userToken ||null
            }
        });
    }
}
