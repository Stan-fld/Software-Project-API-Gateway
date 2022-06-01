interface IError {
    name: string;
    message: string;
    code?: any;
}

export function createError(name: string, message: string, code?: any) {

    return {errors: [{name, message, code}]};
}

export function mongooseErrors(mongooseError: any) {
    const errors = mongooseError['errors'];
    const code = mongooseError['code'];

    if (errors !== null && errors !== undefined) {

        const list = [];

        for (let key in errors) {
            if (errors.hasOwnProperty(key)) {
                const name = errors[key].name;
                const message = errors[key].message;
                const errorCode = errors[key].code;
                const error: IError = {name, message, code: errorCode};
                list.push(error);
            }
        }

        return {errors: list};
    } else if (code !== null && code !== undefined) {

        const errorModel: IError = {name: '', message: mongooseError['errmsg'], code: mongooseError['code'].toString()};

        return {errors: [errorModel]};
    }

    return [];
}
