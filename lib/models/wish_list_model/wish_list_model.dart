class WishListModel {
  int? totalProducts;
  List<Products>? products;

  WishListModel({this.totalProducts, this.products});

  WishListModel.fromJson(Map<String, dynamic> json) {
    totalProducts = json['total-products'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total-products'] = this.totalProducts;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? title;
  String? image;
  String? price;

  Products({this.title, this.image, this.price});

  Products.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['price'] = this.price;
    return data;
  }
}
