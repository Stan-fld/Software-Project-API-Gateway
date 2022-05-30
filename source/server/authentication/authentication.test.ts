import {ObjectId} from "mongodb";
import request from 'supertest';
import {User} from "../../db/user.model";
import DoneCallback = jest.DoneCallback;
import app from "../../server";
import {roles} from "../../middleware/enums";

describe('POST /user', () => {

    beforeEach(removeUsers);
    it('should create user', (done) => {

        const user = {
            email: 'StanIslasfoilLard@yahoO.com',
            password: 'azertyui',
            phone: '+33606060606',
            firstName: 'Stanislas',
            lastName: 'Foillard',
            birthday: new Date('2000-02-02'),
            roles: [roles.admin, roles.user]
        }

        const clientInfo = {
            client: 'iOS',
            clientId: new ObjectId().toHexString()
        }

        request(app)
            .post('/user')
            .send({user, clientInfo})
            .expect(201)
            .expect((res) => {
                expect(res.body.data.user.firstName).toBe(user.firstName);
                expect(res.body.data.user.lastName).toBe(user.lastName);
                expect(res.body.data.user.birthday).toBe('2000-02-02T00:00:00.000Z');
                expect(res.body.data.user.roles).toStrictEqual(user.roles);
                expect(res.body.data.user.email).toBe(user.email.toLowerCase());
                expect(res.body.data.user.password).not.toBe(user.password);

            })
            .end((err) => {

                if (err) {
                    return done(err);
                }

                User.findOne({email: user.email.toLowerCase()}).then((currentUser) => {
                    expect(currentUser).toBeTruthy();
                    done();
                }).catch((e) => {
                    done(e);
                })
                done();
            });
    });
});

describe('POST /user/login', () => {

    beforeEach(removeUsers);
    it('should create and logged user', (done) => {

        const user = {
            email: 'StanIslasfoilLard@yahoO.com',
            password: 'azertyui',
            phone: '+33606060606',
            firstName: 'Stanislas',
            lastName: 'Foillard',
            birthday: new Date('2000-02-02'),
            roles: [roles.admin, roles.user]
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

function removeUsers(done: DoneCallback) {
    User.deleteMany({}).then(() => {
            done();
        }
    )
}
