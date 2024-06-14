class CategoryDetailsModel {
  bool? success;
  Data? data;

  CategoryDetailsModel({this.success, this.data});

  CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
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
        ?  Variants.fromJson(json['variants'])
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
        images!.add(Images.fromJson(v));
      });
    }
    productTitle = json['product_title'];
    if (json['variantsData'] != null) {
      variantsData = <VariantsData>[];
      json['variantsData'].forEach((v) {
        variantsData!.add(VariantsData.fromJson(v));
      });
    }
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    if (variants != null) {
      data['variants'] = variants!.toJson();
    }
    data['product_id'] = productId;
    data['product_image'] = productImage;
    data['product_description'] = productDescription;
    data['reward_points'] = rewardPoints;
    data['product_status'] = productStatus;
    data['client_id'] = clientId;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['product_title'] = productTitle;
    if (variantsData != null) {
      data['variantsData'] = variantsData!.map((v) => v.toJson()).toList();
    }
    data['tags'] = tags;
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
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['color'] = color;
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
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['image_path'] = imagePath;
    data['image_id'] = imageId;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['variant_id'] = variantId;
    data['quantity'] = quantity;
    data['color'] = color;
    data['size'] = size;
    data['style'] = style;
    data['material'] = material;
    return data;
  }
}
