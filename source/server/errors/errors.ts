export function createError(name: string, message: string, code: any) {

    return {data: {name, message}, code: code};

}
