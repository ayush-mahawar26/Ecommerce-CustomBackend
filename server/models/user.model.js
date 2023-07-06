const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
	username: {
		type: String,
		require: true,
		trim: true,
	},
	email: {
		type: String,
		require: true,
		trim: true,
	},
	password: {
		type: String,
		require: true,
		trim: true,
	},
	phn: {
		type: String,
		default: "",
	},
	addr: {
		type: String,
		trim: true,
		default: "",
	},
	type: {
		type: String,
		require: true,
		trim: true,
	},
});

const User = mongoose.model("user", userSchema);

module.exports = User;
