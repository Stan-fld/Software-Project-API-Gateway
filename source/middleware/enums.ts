export const roles = {
    admin: 'admin',
    user: 'user',
    guest: 'guest',
    list: function () {
        return [this.admin, this.user, this.guest];
    }
}
