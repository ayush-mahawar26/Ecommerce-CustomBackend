const { Pool } = require('pg')


const client = new Pool({
    user: "ayushm",
    database: "nodelogin",
    password: "ayush123",
});


// user: "ayushm",
// host: process.env.DB_HOST,
// database: "nodelogin",
// password : "ayush123",

client.connect(function (err) {
    if (err) throw err;

    console.log("connected to db !!")
})

module.exports = { client }