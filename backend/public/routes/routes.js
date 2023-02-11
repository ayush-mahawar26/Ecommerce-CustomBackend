const express = require('express');
const verifyUser = require('../routes/authenticate/auth');
const { AuthenticationController } = require('../controller/authentication.controller');
const { application } = require('express');
const router = express.Router();
require('dotenv').config()


router.get("/", (req, res) => {
    res.send("home")
})

// CREATE USER INTO DATABASE 
router.post("/register", AuthenticationController.createUserController);

// LOGIN USER 
router.post("/signin",  AuthenticationController.loginUserController);


module.exports = router;