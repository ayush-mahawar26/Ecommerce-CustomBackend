const express = require("express");
const app = express();
const dotenv = require("dotenv").config();
const PORT = process.env.PORT;
const dbConfig = require("./dbconfig/dbconf");

app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.use(require("./routes/routes"));
app.use(require("./routes/admin.routes"));

app.listen(PORT, () => {
	console.log("server is running sat 8080");
});
