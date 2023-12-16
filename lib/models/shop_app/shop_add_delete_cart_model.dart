class AddDeleteCartModel {
  bool? status;
  String? message;
  Data? data;

  AddDeleteCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  int? quantity;
  CartProduct? product;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ? CartProduct.fromJson(json['product']) : null;
  }
}

class CartProduct {
  int? id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  String? image;
  String? name;
  String? description;

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
