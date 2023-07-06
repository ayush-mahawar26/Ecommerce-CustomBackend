const { urlencoded } = require("express");
const User = require("../models/user.model");
const jwt = require("jsonwebtoken");

class AuthMiddleware {
	static async authenticateTokenMiddleware(req, res, next) {
		const token = req.header("jwt");
		console.log(token);
		if (token == undefined) {
			return res.json({
				authenticate: false,
				mssg: "Failed to get the token",
			});
		}

		const verfied = await jwt.verify(token, "securityKey");
		if (!verfied) {
			return res.json({
				authenticate: false,
				mssg: "UnAuthorized Token is sent",
			});
		}

		req.token = token;
		req.userid = verfied.id;

		next();
	}

	static async adminAuth(req, res, next) {
		const token = req.header("jwt");
		console.log(token);
		if (token == undefined) {
			return res.json({
				authenticate: false,
				mssg: "Failed to get the token",
			});
		}

		const verfied = await jwt.verify(token, "securityKey");
		if (!verfied) {
			return res.json({
				authenticate: false,
				mssg: "UnAuthorized Token is sent",
			});
		}

		const user = await User.findById({ _id: verfied.id });
		if (user.type == "user") {
			return res.json({
				authenticate: false,
				mssg: "You are not Admin",
			});
		}
		req.token = token;
		req.userid = verfied.id;

		next();
	}
}

module.exports = AuthMiddleware;
