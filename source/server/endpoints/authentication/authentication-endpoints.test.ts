import request from 'supertest';
import app from "../../../server";

describe('POST /user/register', () => {
    it('should register user', (done) => {

        const user = {
            firstName: 'John',
            lastName: 'Doe',
            email: 'john@example.com',
            address: '123 Main St',
            phone: '+33606060606',
            password: '12345678'
        };

        request(app)
            .post('/user/register')
            .send(user)
            .expect(201)
            .then((res) => {

                if (res.error) {
                    console.log(res.error);
                }

                expect(res.body.data.id).toBeDefined();
                expect(res.body.data.firstName).toBe('John');
                expect(res.body.data.lastName).toBe('Doe');
                expect(res.body.data.phone).toBe('+33606060606');
                expect(res.body.data.address).toBe('123 Main St');
                expect(res.body.data.accessToken).toBeDefined();
                expect(res.body.data.password).not.toBeDefined();
                expect(res.body.data.role.id).toBeDefined();
                expect(res.body.data.role.name).toBe('client');

                done();
            });
    });

    it('Should return an error for a missing first name', (done) => {

        const user = {
            lastName: 'Doe',
            email: 'jOhn@Example.com',
            address: '123 Main St',
            phone: '+33606060606',
            password: '12345678'
        };

        request(app)
            .post('/user/register')
            .send(user)
            .then((res) => {

                expect(res.status).toBe(400);
                expect(res.body.data.name).toBe('NoFirstNameFound');

                done();
            });
    });
});

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
    it('should return error for incorrect email or password', (done) => {

        request(app)
            .post('/user/login')
            .send({email: 'john@exampl.com', password: '12345678'})
            .then((res) => {

                expect(res.status).toBe(401);
                expect(res.body.data.name).toBe('InvalidEmailOrPassword');

                done();
            });
    });
});
