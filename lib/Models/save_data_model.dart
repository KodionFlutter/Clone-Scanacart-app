class SaveData {
  int? quantity;
  String? imageURL;
  Variants? variants;
  int? variantId;
  int? productId;
  String? productName;
  int? points;
  int? clientId;
  String? categoryId;

  SaveData(
      {this.quantity,
      this.imageURL,
      this.variants,
      this.variantId,
      this.productId,
      this.productName,
      this.points,
      this.clientId,
      this.categoryId});

  SaveData.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    imageURL = json['imageURL'];
    variants =
        json['variants'] != null ? Variants.fromJson(json['variants']) : null;
    variantId = json['variantId'];
    productId = json['productId'];
    productName = json['productName'];
    points = json['points'];
    clientId = json['client_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['quantity'] = quantity;
    data['imageURL'] = imageURL;
    if (variants != null) {
      data['variants'] = variants!.toJson();
    }
    data['variantId'] = variantId;
    data['productId'] = productId;
    data['productName'] = productName;
    data['points'] = points;
    data['client_id'] = clientId;
    data['category_id'] = categoryId;
    return data;
  }
}

class Variants {
  String? color;
  String? size;

  Variants({this.color, this.size});

  Variants.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['size'] = this.size;
    return data;
  }
}
