const {check} = require('express-validator')

exports.userSignupValidator = [
    check('name')
        .not()
        .isEmpty()
        .withMessage('Please enter your name'),
    check('email')
        .isEmail()
        .withMessage('Please enter a valid email address'),
    check('password')
        .isLength({min: 6})
        .withMessage('Password must be at least 6 characters long')
]

exports.userSigninValidator = [
    check('email')
        .isEmail()
        .withMessage('Please enter a valid email address'),
    check('password')
        .isLength({min: 6})
        .withMessage('Password must be at least 6 characters long')
]