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
            baseURL:'htt://localhost:8080/',
            headers: {
                'Content-Type': 'application/json',
                'trx-auth': transactionToken || null,
                'x-auth': userToken ||null
            }
        });
    }
}
