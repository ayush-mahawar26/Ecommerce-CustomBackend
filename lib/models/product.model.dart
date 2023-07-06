class ProductModel {
  String? author;
  String? name;
  String? description;
  int? price;
  int? quantity;
  List<String>? images;
  String? category;

  ProductModel(
      {this.author,
      this.name,
      this.description,
      this.price,
      this.quantity,
      this.images,
      this.category});

  ProductModel.fromJson(Map<dynamic, dynamic> json) {
    author = json['author'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    images = json['images'].cast<String>();
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = author;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['images'] = this.images;
    data['category'] = this.category;
    return data;
  }
}
