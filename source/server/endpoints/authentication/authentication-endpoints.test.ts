import request from 'supertest';
import app from "../../../server";

describe('POST /user/login', () => {

    it('should logged user', (done) => {

        request(app)
            .post('/user/login')
            .send({email: 'john@example.com', password: '12345678'})
            .then((res) => {

                if (res.error) {
                    console.log(res.error);
                }

                expect(res.body.data.firstName).toBe('John');
                expect(res.body.data.lastName).toBe('Doe');
                expect(res.body.data.phone).toBe('+33606060606');
                expect(res.body.data.role.name).toBe('client');


                done();
            });
    });
});
