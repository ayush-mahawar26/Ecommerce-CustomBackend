const jwt = require('jsonwebtoken')
const { client } = require('../routes/dbconfig/dbconfig')
const bcrypt = require('bcrypt')

class AuthenticationRepo {
    static async createUserRepositry(req, res) {
        const { name, email, password } = req.body;

        client.query("SELECT * FROM users where email = $1", [email], async (err, results) => {
            if (err) throw err;

            if (results.rowCount >= 1) {
                return res.json({
                    authenticate : "false" ,
                    message : "User Already Exist"
                });
            } else {

                let encryptedPass = await bcrypt.hash(password, 10);

                const token = await jwt.sign(
                    {
                        email
                    },
                    process.env.SECRET_KEY,
                    {
                        expiresIn: '24h'
                    }
                );
                if (token) {

                    const result = await client.query(
                        "INSERT INTO users (name , email , password) VALUES ($1 ,$2 ,$3 )", [name, email, encryptedPass]
                    )

                    if (result) {
                        return res.json({
                            authenticate: "true",
                            message: token
                        })
                    } else {
                        return res.json({
                            authenticate: "false",
                            message: "error in entering data"
                        })
                    }
                }

                return res.json({
                    authenticate: "false",
                    message: "error"
                })
            }

        })
    }

    static async loginUserRepo(req, res) {
        const { name, email, password } = req.body;
        console.log("executing...")
        await client.query("SELECT * FROM users WHERE email = $1", [email], async (err, results) => {
            if (err) {
                return res.json({
                    authenticate: "false",
                    message : err
                })
            }


            if (results.rowCount >= 1) {
                const encrypted = results.rows[0]['password'];
                console.log(encrypted);
                const isSame = await bcrypt.compare(password, encrypted);
                if (isSame) {
                    const jwtSign = jwt.sign({
                        email
                    },
                    process.env.SECRET_KEY, 
                    {
                        expiresIn : '24h'
                    }
                    )

                    if(jwtSign){
                        const results = await client.query("SELECT * FROM users where email = $1", [email])
                        if (results) {
                            return res.json({
                                authenticate: "true",
                                message : jwtSign
                            })
                        }
                    }else{
                        return res.json({
                            authenticate: "true",
                            message : "error Occured"
                        })
                    }
                    
                }
                else {
                    return res.json({
                        authenticate: "false",
                        message: "Invalid credential"
                    })
                }
            } else {
                return res.json({
                    authenticate: "false",
                    message : "Create Account"
                })
            }
        });



    }
}

module.exports = { AuthenticationRepo }