const mongoose = require("mongoose");

const connected = mongoose.connect(process.env.DB_URL).then(() => {
	console.log("connected !!");
});

module.exports = connected;
