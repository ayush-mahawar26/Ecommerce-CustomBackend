const User = require("../models/user.model");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const dotenv = require("dotenv").config();

class AuthController {
	// Sign Up Controller

	static async signUpController(req, res) {
		const { username, email, password, phn, addr, type } = req.body;

		try {
			const exist = await User.findOne({ email });

			console.log("here");

			if (exist) {
				return res.json({
					authenticate: false,
					mssg: "User Already Exist",
				});
			} else {
				console.log(password);
				bcrypt.hash(password, 10, async (err, password) => {
					if (err) {
						return res.json({
							authenticate: false,
							mssg: err.message,
						});
					}
					// console.log(password);
					let user = new User({
						username,
						email,
						password,
						phn,
						addr,
						type,
					});

					user = await user.save();

					const token = await jwt.sign({ id: user._id }, "securityKey");

					req.token = token;
					req.userid = user._id;
					return res.json({
						authenticate: true,
						mssg: "successfully signed up",
						token,
						...user._doc,
					});
				});
			}
		} catch (error) {
			return res.json({
				authenticate: false,
				mssg: error.message,
			});
			// console.log(error);
		}
	}

	// Sign In Controller
	static async signInController(req, res) {
		const { email, password } = req.body;

		try {
			const user = await User.findOne({ email });

			if (!user) {
				return res.json({
					authenticate: false,
					mssg: "User Not Exist",
				});
			} else {
				const matched = await bcrypt.compare(password, user.password);

				if (!matched) {
					return res.json({
						authenticate: false,
						mssg: "Invalid Credential Entered",
					});
				}

				const token = await jwt.sign({ id: user._id }, "securityKey");

				return res.json({
					authenticate: true,
					mssg: "Successfully Sign In",
					token: token,
					...user._doc,
				});
			}
		} catch (error) {
			return res.json({
				authenticate: false,
				mssg: error.message,
			});
		}
	}

	static async validToken(req, res) {
		const token = req.header("jwt");

		if (token === undefined) {
			return res.json({
				authenticate: false,
				verified: false,
				mssg: "Failed to get the token",
			});
		}

		const verfied = await jwt.verify(token, "securityKey");
		if (!verfied) {
			return res.json({
				authenticate: false,
				verified: false,
				mssg: "UnAuthorized Token is sent",
			});
		}

		return res.json({
			authenticate: true,
			verified: true,
			mssg: "Verified",
		});
	}
}

module.exports = AuthController;
