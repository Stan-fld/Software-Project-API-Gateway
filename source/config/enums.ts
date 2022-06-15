export const reqCat = {
    get: 'GET',
    put: 'PUT',
    patch: 'PATCH',
    post: 'POST',
    delete: 'DELETE',
    option: 'OPTION',
    list: function () {
        return [this.get, this.put, this.patch, this.post, this.delete, this.option];
    }
}
