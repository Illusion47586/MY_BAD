const express = require('express')
const router = express.Router();
const {signup, signin, signout, allUsers} = require('../controllers/auth');

//Validators

const {runValidation} = require('../validators')
const {userSignupValidator, userSigninValidator} = require('../validators/auth')

router.get('/',function(req,res){
    res.send("app is live")
})


router.post('/signup', userSignupValidator, runValidation, signup);
router.post('/signin', userSigninValidator, runValidation, signin);
router.get('/allusers', allUsers)
router.get('/signout', signout);


module.exports = router;