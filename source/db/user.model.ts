import mongoose from 'mongoose';
import validator from "validator";
import jwt from 'jsonwebtoken';
import {createError, mongooseErrors, objectNotFound} from "../server/errors/errors";
import bcrypt from 'bcrypt';
import {bodyPick} from "../middleware/utils";
import {roles} from "../middleware/enums";


const UserSchema = new mongoose.Schema({
    firstName: {
        type: String,
        required: true,
        minLength: 1
    },
    lastName: {
        type: String,
        required: true,
        minLength: 1
    },
    email: {
        type: String,
        required: true,
        minLength: 5,
        trim: true,
        unique: true,
        validate: {
            validator: (value: string) => {
                return validator.isEmail(value);
            },
            message: '{VALUE} is not a valid email'
        }
    },
    password: {
        type: String,
        required: true,
        minlength: 6
    },
    phone: {
        type: String,
        required: true
    },
    birthday: {
        type: Date,
        required: true
    },
    roles: [{
        type: String,
        enum: roles.list(),
        required: true
    }],
    photo: {
        type: String,
        default: null
    },
    tokens: [{
        client: {
            type: String,
            required: true
        },
        clientId: {
            type: String,
            required: true
        },
        accessToken: {
            type: String
        },
        refreshToken: {
            type: String
        }
    }]
}, {timestamps: true});

UserSchema.pre('save', function (next) {

    if (this.isModified('password')) {
        bcrypt.genSalt(10, (err, salt) => {
            bcrypt.hash(this.password, salt, (_err, hash) => {
                this.password = hash;
                next();
            });
        });
    } else {
        next();
    }

});

export class User extends mongoose.model('User', UserSchema) {

    toJSON() {

        return bodyPick(['_id', 'firstName', 'lastName', 'email', 'phone', 'photo', 'birthday', 'roles', 'createdAt', 'updatedAt'], this.toObject());

    }

    verifyPassword(password: string) {

        return bcrypt.compare(password, this.password).then((result) => {
            if (result) {
                return Promise.resolve(true);
            } else {
                return Promise.reject(createError('PasswordIncorrect', 'The supplied password does not match the user password'));
            }
        });

    }

    createAuthToken(client: string, clientId: string) {

        // the access token should expire in 1 hour
        // because we provide iat: Date.now() the expiresIn is in milliseconds instead of seconds
        const newAccessToken = jwt.sign({
            _id: this._id.toHexString(),
            client,
            clientId,
            iat: Date.now() / 1000
        }, process.env.JWT_SECRET!, {expiresIn: '1h'}).toString();
        // the refresh token should expire in 7 days, we cannot use the string notation as iat and exp are in milliseconds, so we created the expires in with multiplication.
        const newRefreshToken = jwt.sign({
            _id: this._id.toHexString(),
            client,
            clientId,
            iat: Date.now() / 1000
        }, process.env.JWT_SECRET!, {expiresIn: '7d'}).toString()

        const tokens = this.tokens.filter((token: any) => {

            return token.client === client && token.clientId === clientId;
        })

        if (tokens.length == 0) {
            // no tokens exist add one to the list

            const newToken = {
                client,
                clientId,
                accessToken: newAccessToken,
                refreshToken: newRefreshToken
            };

            this.tokens = this.tokens.concat([newToken]);

            return this.save().then((updatedUser: User) => {

                return {
                    user: updatedUser,
                    token: {
                        accessToken: newAccessToken,
                        refreshToken: newRefreshToken
                    }
                };
            });

        } else {

            // token exists update it.
            const token = tokens[0];
            token.accessToken = newAccessToken;
            token.refreshToken = newRefreshToken;

            return this.save().then((updatedUser: User) => {

                return {
                    user: updatedUser,
                    token: {
                        accessToken: newAccessToken,
                        refreshToken: newRefreshToken
                    }
                };
            });
        }

    }

    static findWithEmailPass(email: string, password: string) {

        return this.findOne({email}).then((user: User) => {

            if (!user) {
                return Promise.reject(objectNotFound('User', email));
            }

            return bcrypt.compare(password, user.password).then((res) => {

                if (res) {
                    return Promise.resolve(user);
                } else {
                    return Promise.reject(createError('PasswordIncorrect', 'The supplied password does not match the users password'));
                }

            })

        }).catch((e: Error) => {
            return Promise.reject(mongooseErrors(e));
        });

    }

    static findWithAccessToken(accessToken: string) {

        let decodedAccessToken;
        let decodedRefreshToken;

        try {
            decodedAccessToken = jwt.verify(accessToken, process.env.JWT_SECRET!, {ignoreExpiration: true});
        } catch (e) {
            return Promise.reject(createError('MalformedToken', 'AccessToken is malformed'));
        }

        if (decodedAccessToken.exp * 1000 < Date.now()) {
            this.findOne({
                '_id': decodedAccessToken._id,
                'tokens.accessToken': accessToken
            }).then((u) => {
                let tokenIndexToUpdate = u.tokens.findIndex(t => t.accessToken === accessToken);
                try {
                    decodedRefreshToken = jwt.verify(u.tokens[tokenIndexToUpdate].refreshToken, process.env.JWT_SECRET!, {ignoreExpiration: true});
                } catch (e) {
                    return Promise.reject(createError('MalformedToken', 'RefreshToken is malformed'));
                }

                if (decodedRefreshToken.exp * 1000 < Date.now()) {
                    return Promise.reject(createError('AccessAndRefreshTokensExpired', 'The access and refresh tokens has expired'));
                }

                u.tokens[tokenIndexToUpdate].accessToken = jwt.sign({
                    _id: u._id.toHexString(),
                    client: u.client,
                    clientId: u.clientId,
                    iat: Date.now() / 1000
                }, process.env.JWT_SECRET!, {expiresIn: '1h'}).toString();

                return u.save();
            });
        }

        return this.findOne({
            '_id': decodedAccessToken._id,
            'tokens.accessToken': accessToken
        });
    }
}
