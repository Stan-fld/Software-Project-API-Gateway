import {ObjectId} from "mongodb";
import request from 'supertest';
import app from "../../server";
import {PopulateRoles, PopulateTransactions} from "../seed-data";
import {roles} from "../../config/enums";

describe('POST /register/:transactionCode', () => {

    beforeEach(PopulateRoles);
    beforeEach(PopulateTransactions);
    it('should create restaurant', (done) => {

        const user = {
            email: 'StanIslasfoilLard@yahoO.com',
            password: 'azertyui',
            firstName: 'Stanislas',
            lastName: 'Foillard',
        }

        const clientInfo = {
            client: 'iOS',
            clientId: new ObjectId().toHexString()
        }

        request(app)
            .post('/register/CR')
            .send({user, clientInfo, role: roles.restau})
            .expect(201)
            .expect((res) => {
                console.log(res.body);
                /*
                                expect(res.body.data.user.firstName).toBe(user.firstName);
                                expect(res.body.data.user.lastName).toBe(user.lastName);
                                expect(res.body.data.user.email).toBe(user.email.toLowerCase());
                                expect(res.body.data.user.password).not.toBe(user.password);

                 */


            })
            .end((err) => {

                if (err) {
                    return done(err);
                }


                done();
            });
    });
});

describe('POST /user/login', () => {

    it('should create and logged user', (done) => {

        const user = {
            email: 'StanIslasfoilLard@yahoO.com',
            password: 'azertyui',
            phone: '+33606060606',
            firstName: 'Stanislas',
            lastName: 'Foillard',
            birthday: new Date('2000-02-02')
        }

        const clientInfo = {
            client: 'iOS',
            clientId: new ObjectId().toHexString()
        }

        request(app)
            .post('/user')
            .send({user, clientInfo})
            .expect(201)
            .then((res) => {

                if (res.error) {
                    console.log(res.error);
                }

                const signupAccessToken = res.body.data.tokens.accessToken;

                request(app)
                    .post('/user/login')
                    .send({
                        email: 'StanIslasfoilLard@yahoO.com',
                        password: 'azertyui',
                        client: clientInfo.client,
                        clientId: clientInfo.clientId
                    })
                    .then((res) => {

                        if (res.error) {
                            console.log(res.error);
                        }

                        expect(signupAccessToken).not.toBe(res.body.data.tokens.accessToken);

                        done();
                    });
            });
    });
});

