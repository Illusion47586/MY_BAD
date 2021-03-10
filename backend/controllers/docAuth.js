const Doctor = require('../models/doctor');
const shortId = require('shortid')
const jwt = require('jsonwebtoken')
const expressJwt = require('express-jwt')

exports.signup = (req, res) => {
    Doctor.findOne({email: req.body.email}).exec((err, user) => {
        if(user) {
            return res.status(400).json({
                error: 'Email is taken'
            })
        }

        const {name, email, password} = req.body
        let username = shortId.generate()
        let profile =  `${process.env.CLIENT_URL}/profile/${username}`

        let newUser = new Doctor({name, email, password, profile, username});
        newUser.save((err, success) => {
            if(err) {
                return res.status(400).json({
                    error: err
                })
            }
            res.json({
                user: success
            })
            // res.json({
            //     message: 'Signup successful! Please login to your account'
            // })
        })
    })
}

exports.singleDoctor = (req, res) => {
    const email = 'ayush3982@gmail.com'
    Doctor.findOne({email}).exec((err, doctor) => {
        if (err) {
            return res.status(400).json({
                error: 'ERROR'
            });
        }
        const {photo, name, phoneNo} = doctor;
        res.json({
            doctor: {photo, name, phoneNo}
        });
    });
};

exports.signin = (req, res) => {
    const {email, password} = req.body
    Doctor.findOne({email}).exec((err, user) => {
        // check if the user exist
        if(err || !user) {
            return res.status(400).json({
                error: "Doctor with this email doesn't exist, Please signup"
            })
        }
        // authenticate the user
        if(!user.authenticate(password)) {
            return res.status(400).json({
                error: "Email and password do not match"
            })
        }
        // generate a token and send to client
        const token = jwt.sign({_id: user._id}, process.env.JWT_SECRET, {expiresIn: '1d'})

        res.cookie('token', token, {expiresIn: '1d'})
        const {_id, username, name, email, role} = user;
        return res.json({
            token, 
            user: {_id, username, name, email, role}
        })
    })
  
}

exports.signout = (req, res) => {
    res.clearCookie('token')
    res.json({
        message: 'Signout success'
    })
}

exports.requireSignin = expressJwt({
    secret: process.env.JWT_SECRET,
    algorithms: ["HS256"], 
    userProperty: "auth",
})