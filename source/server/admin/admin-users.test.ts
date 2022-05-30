import request from 'supertest';
import app from '../../server'
import {PopulateUsers, SeedUsers} from "../seed-data";

describe('GET /admin/users', () => {

    beforeEach(PopulateUsers)

    it('should fetch users', (done) => {
        request(app)
            .get('/admin/users')
            .set('x-auth', SeedUsers[0].tokens[0].accessToken)
            .then((res) => {

                if (res.error) {
                    console.log(res.error);
                }

                const users = res.body.data;
                expect(users.length).toBe(3);

                done();
            });
    });

    it('should return an error for user is not admin', (done) => {
        request(app)
            .get('/admin/users')
            .set('x-auth', SeedUsers[1].tokens[0].accessToken)
            .then((res) => {
                expect(res.error).toBeTruthy();

                done();
            });
    });
});

describe('POST /admin/:userId/deleteUser', () => {

    beforeEach(PopulateUsers)

    it('should delete a user', (done) => {
        request(app)
            .post('/admin/' + SeedUsers[1]._id + '/deleteUser')
            .set('x-auth', SeedUsers[0].tokens[0].accessToken)
            .send({
                password: 'azertyui'
            })
            .then((res) => {

                if (res.error) {
                    console.log(res.error);
                }

                expect(res.body.data).toBe(true);

                done();
            });
    });

    it('should return an error for user is not exist', (done) => {
        request(app)
            .post('/admin/12345/deleteUser')
            .set('x-auth', SeedUsers[0].tokens[0].accessToken)
            .send({
                password: 'azertyui'
            })
            .then((res) => {
                expect(res.error).toBeTruthy();

                done();
            });
    });
});
