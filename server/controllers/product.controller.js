const Product = require("../models/product.model");

class ProductController {
	static async getAllProducts(req, res) {
		try {
			let product = await Product.find();

			return res.json({
				getted: true,
				product,
			});
		} catch (e) {
			return res.json({
				getted: false,
				mssg: e.message,
			});
		}
	}

	static async getProductByUser(req, res) {
		var username = req.query.username;
		try {
			let product = await Product.find({
				author: username,
			});
			return res.json({
				getted: true,
				product,
			});
		} catch (e) {
			return res.json({
				getted: false,
				mssg: e.message,
			});
		}
	}

	static async addProduct(req, res) {
		const { author, name, description, price, quantity, images, category } =
			req.body;

		try {
			let product = new Product({
				author,
				name,
				description,
				price,
				quantity,
				images,
				category,
			});

			product = await product.save();

			return res.json({
				added: true,
				...product._doc,
			});
		} catch (error) {
			return res.json({
				added: false,
				mssg: error.message,
			});
		}
	}
}

module.exports = ProductController;
