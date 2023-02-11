
const express = require('express');
const app = express();

require('../public/routes/dbconfig/dbconfig');
const dotenv = require('dotenv')

dotenv.config({ path: "public/.env" })

console.log(process.env.SECRET_KEY)

app.use(express.urlencoded({ extended: false }))
app.use(express.json())
app.use(require('./routes/routes'))
require('../public/routes/dbconfig/dbconfig')


app.listen(process.env.PORT, () => {
    console.log("server is running sat 8080")
})