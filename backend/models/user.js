const mongoose = require('mongoose');
const crypto = require('crypto');

const userSchema = new mongoose.Schema({
    username: {
        type: 'string',
        trim: true,
        required: true,
        max: 32,
        unique: true,
        index: true,
        lowercase: true
    },
    name: {
        type: 'string',
        trim: true,
        required: true,
        max: 32,
    },
    email: {
        type: 'string',
        trim: true,
        required: true,
        unique: true,
        lowercase: true
    },
    profile: {
        type: 'string',
        required: true
    },
    hashed_password: {
        type: 'string',
        required: true
    },
    salt: String,
    about: {
        type: String
    },
    role: {
        type: 'string',
        required: true,
        trim: true,
        default: 'user'
    },
    photo: {
        data: Buffer,
        contentType: String
    },
    resetPasswordLink: {
        data: String,
        default: ''
    },
    bloodPressure: {
        data: String,
        default: ''
    },
    dob: {
        data: Date,
        default: ''
    },
    pastDiseases: {
        data: String,
        default: ''
    },
    height: {
        data: Number,
        default: ''
    },
    weight: {
        data: Number,
        default: ''
    }
}, {timestamp: true})

userSchema.virtual('password')
    .set(function(password) {
        // create a temporary variable called _password
        this._password = password
        //generate salt
        this.salt = this.makeSalt()
        // encrypt the password
        this.hashed_password = this.encryptPassword(password)
    })
    .get(function() {
        return this._password;
    })

userSchema.methods = {
    authenticate: function(plainText) {
        return this.encryptPassword(plainText) === this.hashed_password
    },

    encryptPassword: function(password) {
        if(!password) return ''
        try {
            return crypto
                .createHmac('sha1', this.salt)
                .update(password)
                .digest('hex')
        } catch (err) {
            return ''
        }
    },
    makeSalt: function() {
        return Math.round(new Date().valueOf() * Math.random())  + '';
    }
}

module.exports = mongoose.model('User', userSchema);