import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ecommerce_custom_backend/constants/global.variable.dart';
import 'package:ecommerce_custom_backend/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_custom_backend/models/product.model.dart';

class AdminServices {
  String baseUrl = GlobalVariables().baseUrl;
  Map<String, String> header = GlobalVariables().headers;

  getAllProducts() async {
    http.Response res = await http.get(Uri.parse("$baseUrl/get/product"));
    Map responseMap = await jsonDecode(res.body);

    print(responseMap);

    return responseMap;
  }

  getProductBySeller(String username) async {
    http.Response res =
        await http.get(Uri.parse("$baseUrl/get/product/by?username=$username"));

    Map resMap = await jsonDecode(res.body);

    print(resMap);

    return resMap;
  }

  sellProduct(String author, String name, String descp, int price, int quantity,
      List<File> images, String category) async {
    try {
      final cloudinary = CloudinaryPublic("dma4ggqvk", "jjzkan92");
      List<String> imgUrls = [];

      for (File i in images) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(i.path, folder: name));
        imgUrls.add(res.url);
      }

      ProductModel product = ProductModel(
          author: author,
          name: name,
          description: descp,
          price: price,
          quantity: quantity,
          images: imgUrls,
          category: category);
      Uri uri = Uri.parse("$baseUrl/admin/add/product");
      http.Response productRes = await http.post(uri,
          body: jsonEncode(product.toJson()), headers: header);

      Map jsonProduct = await json.decode(productRes.body);

      return jsonProduct;
    } catch (e) {
      print(e.toString());
    }
  }
}
