import {ObjectId} from "mongodb";
import request from 'supertest';
import app from "../../server";
import {PopulateRoles, PopulateTransactions, SeedRoles} from "../seed-data";

describe('POST /register/:transactionCode', () => {

    beforeEach(PopulateRoles);
    beforeEach(PopulateTransactions);

    it('should create restaurant', (done) => {

        const restaurant = {
            email: 'StanIslasfoilLard@yahoO.com',
            password: 'azertyui',
            firstName: 'Stanislas',
            lastName: 'Foillard'
        }

        const clientInfo = {
            client: 'iOS',
            clientId: new ObjectId().toHexString()
        }

        request(app)
            .post('/register/CR')
            .send({restaurant, clientInfo})
            .expect((res) => {

                if (res.error) {
                    console.log(res.error);
                }

                expect(res.body.data.restaurant.firstName).toBe(restaurant.firstName);
                expect(res.body.data.restaurant.lastName).toBe(restaurant.lastName);
                expect(res.body.data.restaurant.email).toBe(restaurant.email.toLowerCase());
                expect(res.body.data.restaurant.password).not.toBe(restaurant.password);
                expect(res.body.data.restaurant.role).toBe(SeedRoles[1].id);

            })
            .end((err) => {

                if (err) {
                    return done(err);
                }

                done();
            });
    });
});


describe('POST /login/:transactionCode', () => {

    beforeEach(PopulateRoles);
    beforeEach(PopulateTransactions);

    it('should create and logged restaurant', (done) => {

        const restaurant = {
            email: 'StanIslasfoilLard@live.fr',
            password: 'azertyui',
            firstName: 'Stanislas',
            lastName: 'Foillard'
        }

        const clientInfo = {
            client: 'iOS',
            clientId: new ObjectId().toHexString()
        }

        request(app)
            .post('/register/CR')
            .send({restaurant, clientInfo})
            .then((res) => {

                if (res.error) {
                    console.log(res.error);
                }

                const signupAccessToken = res.body.data.tokens.accessToken;

                request(app)
                    .post('/login/LR')
                    .send({
                        email: 'StanIslasfoilLard@live.fr',
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
