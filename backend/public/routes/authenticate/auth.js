
const jwt = require("jsonwebtoken")

const verifyUser = async (req, res, next) => {
    const token = req.headers['token'];
    if (token) {
        try {
            await jwt.verify(token, process.env.SECRET_KEY, async (err, jwtData) => {
                if (err) {
                    return res.json({
                        authenticate: false,
                        mssg: "invalid signature"
                    })
                }
                req.email = jwtData.email;
            })
        } catch (error) {
            return res.json({
                authenticate : false,
                mssg: "error"
            })
        }

        next()

    } else {
        return res.json({
            authenticate: false,
            mssg: "provide jwt key"
        })
    }
}

module.exports = verifyUser;