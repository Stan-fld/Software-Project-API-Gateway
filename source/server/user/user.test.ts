import request from 'supertest';
import app from '../../server'
import {PopulateUsers, SeedUsers} from "../seed-data";

describe('PATCH /user/me', () => {

    beforeEach(PopulateUsers)

    it('should update user', (done) => {
        request(app)
            .patch('/user/me')
            .set('x-auth', SeedUsers[2].tokens[0].accessToken)
            .send({firstName: 'Stanislas', lastName: 'Foillard', phone: '+33606060606'})
            .then((res) => {

                if (res.error) {
                    console.log(res.error);
                }

                const user = res.body.data;
                const vUser = SeedUsers[2];

                expect(user).toBeTruthy();
                expect(user.firstName).toBe('Stanislas');
                expect(user.lastName).toBe('Foillard');
                expect(user.phone).toBe('+33606060606');
                expect(user.birthday).toBe('1968-06-06T00:00:00.000Z');
                expect(user.roles).toStrictEqual(vUser.roles);
                expect(user.email).toBe(vUser.email);

                done();
            });
    });
});

describe('PATCH /user/me/password', () => {

    beforeEach(PopulateUsers)

    it('should change user password', (done) => {
        request(app)
            .patch('/user/me/password')
            .set('x-auth', SeedUsers[1].tokens[0].accessToken)
            .send({password: 'azertyui', newPassword: 'iuytreza'})
            .then((res) => {

                if (res.error) {
                    console.log(res.error);
                }

                const user = res.body.data;
                const vUser = SeedUsers[1];

                expect(user).toBeTruthy();
                expect(user.firstName).toBe(vUser.firstName);
                expect(user.lastName).toBe(vUser.lastName);
                expect(user.phone).toBe(vUser.phone);
                expect(user.birthday).toBe("1989-05-05T00:00:00.000Z");
                expect(user.roles).toStrictEqual(vUser.roles);
                expect(user.email).toBe(vUser.email);

                done();
            });
    });
});
