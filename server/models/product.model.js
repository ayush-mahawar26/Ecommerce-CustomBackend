const mongoose = require("mongoose");

const productSchema = mongoose.Schema({
	author: {
		type: String,
		required: true,
	},
	name: {
		type: String,
		required: true,
	},
	description: {
		type: String,
		require: true,
	},
	price: {
		type: Number,
		require: true,
	},
	quantity: {
		type: Number,
		require: true,
	},
	images: [
		{
			type: String,
		},
	],
	category: {
		type: String,
		require: true,
	},
});

const Product = mongoose.model("product", productSchema);

module.exports = Product;
