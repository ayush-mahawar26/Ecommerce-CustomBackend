const express = require("express");

const router = express.Router();
const mongoose = require("mongoose");
const { userSchema } = require("../models/user.model");
const User = require("../models/user.model");
const bcrypt = require("bcrypt");
const salt = 10;
const AuthController = require("../controllers/auth.controller");
const AuthMiddleware = require("../middleware/auth");

router.post("/signup", AuthController.signUpController);
router.post("/signin", AuthController.signInController);

// get user data
router.get(
	"/",
	AuthMiddleware.authenticateTokenMiddleware,
	async (req, res) => {
		const user = await User.findById(req.userid);
		return res.json({
			token: req.token,
			...user._doc,
		});
	}
);

module.exports = router;
