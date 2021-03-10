const express = require('express')
const router = express.Router();
const {signup, signin, signout, singleDoctor} = require('../controllers/docAuth');

//Validators

const {runValidation} = require('../validators')
const {userSignupValidator, userSigninValidator} = require('../validators/auth')

router.post('/dsignup', userSignupValidator, runValidation, signup);
router.post('/dsignin', userSigninValidator, runValidation, signin);
router.get('/dsignout', signout);
router.get('/singledoctor', singleDoctor);

module.exports = router;