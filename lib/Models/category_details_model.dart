class CategoryDetailsModel {
  bool? success;
  Data? data;

  CategoryDetailsModel({this.success, this.data});

  CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? categoryId;
  String? createdAt;
  Variants? variants;
  int? productId;
  String? productImage;
  String? productDescription;
  int? rewardPoints;
  String? productStatus;
  String? clientId;
  List<Images>? images;
  String? productTitle;
  List<VariantsData>? variantsData;
  String? tags;

  Data(
      {this.categoryId,
        this.createdAt,
        this.variants,
        this.productId,
        this.productImage,
        this.productDescription,
        this.rewardPoints,
        this.productStatus,
        this.clientId,
        this.images,
        this.productTitle,
        this.variantsData,
        this.tags});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    variants = json['variants'] != null
        ? new Variants.fromJson(json['variants'])
        : null;
    productId = json['product_id'];
    productImage = json['product_image'];
    productDescription = json['product_description'];
    rewardPoints = json['reward_points'];
    productStatus = json['product_status'];
    clientId = json['client_id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    productTitle = json['product_title'];
    if (json['variantsData'] != null) {
      variantsData = <VariantsData>[];
      json['variantsData'].forEach((v) {
        variantsData!.add(new VariantsData.fromJson(v));
      });
    }
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    if (this.variants != null) {
      data['variants'] = this.variants!.toJson();
    }
    data['product_id'] = this.productId;
    data['product_image'] = this.productImage;
    data['product_description'] = this.productDescription;
    data['reward_points'] = this.rewardPoints;
    data['product_status'] = this.productStatus;
    data['client_id'] = this.clientId;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['product_title'] = this.productTitle;
    if (this.variantsData != null) {
      data['variantsData'] = this.variantsData!.map((v) => v.toJson()).toList();
    }
    data['tags'] = this.tags;
    return data;
  }
}

class Variants {
  String? color;

  Variants({this.color});

  Variants.fromJson(Map<String, dynamic> json) {
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    return data;
  }
}

class Images {
  String? imagePath;
  int? imageId;

  Images({this.imagePath, this.imageId});

  Images.fromJson(Map<String, dynamic> json) {
    imagePath = json['image_path'];
    imageId = json['image_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_path'] = this.imagePath;
    data['image_id'] = this.imageId;
    return data;
  }
}

class VariantsData {
  int? variantId;
  String? quantity;
  String? color;
  String? size;
  String? style;
  String? material;

  VariantsData(
      {this.variantId,
        this.quantity,
        this.color,
        this.size,
        this.style,
        this.material});

  VariantsData.fromJson(Map<String, dynamic> json) {
    variantId = json['variant_id'];
    quantity = json['quantity'];
    color = json['color'];
    size = json['size'];
    style = json['style'];
    material = json['material'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant_id'] = this.variantId;
    data['quantity'] = this.quantity;
    data['color'] = this.color;
    data['size'] = this.size;
    data['style'] = this.style;
    data['material'] = this.material;
    return data;
  }
}
