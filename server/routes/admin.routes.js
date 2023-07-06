const express = require("express");
const ProductController = require("../controllers/product.controller");
const AuthMiddleware = require("../middleware/auth");
const adminRoute = express.Router();

adminRoute.post("/admin/add/product", ProductController.addProduct);

//get product
adminRoute.get("/get/product", ProductController.getAllProducts);

// get product by user
adminRoute.get(`/get/product/by`, ProductController.getProductByUser);

module.exports = adminRoute;
