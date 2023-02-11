const { AuthenticationRepo } = require('../repositry/authentication.repo')

class AuthenticationController {

    // Registering the user into app
    static async createUserController(req, res) {

        const authrepo = AuthenticationRepo;
        await authrepo.createUserRepositry(req, res);

    }


    // Logining the user in the app 
    static async loginUserController(req, res) {
        const loginrepo = AuthenticationRepo;
        await loginrepo.loginUserRepo(req, res);
    }
}

module.exports = { AuthenticationController };
