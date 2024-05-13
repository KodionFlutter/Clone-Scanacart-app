class ViewCategoryModel {
  bool? success;
  List<Data>? data;
  String? categoryName;

  ViewCategoryModel({this.success, this.data, this.categoryName});

  ViewCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['category_name'] = categoryName;
    return data;
  }
}

class Data {
  String? categoryId;
  String? productDescription;
  String? createdAt;
  Variants? variants;
  String? productStatus;
  List<Images>? images;
  String? productTitle;
  int? productRewardPoints;
  int? productId;
  String? productImage;
  String? tags;

  Data(
      {this.categoryId,
      this.productDescription,
      this.createdAt,
      this.variants,
      this.productStatus,
      this.images,
      this.productTitle,
      this.productRewardPoints,
      this.productId,
      this.productImage,
      this.tags});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    productDescription = json['product_description'];
    createdAt = json['created_at'];
    variants =
        json['variants'] != null ? Variants.fromJson(json['variants']) : null;
    productStatus = json['product_status'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    productTitle = json['product_title'];
    productRewardPoints = json['product_reward_points'];
    productId = json['product_id'];
    productImage = json['product_image'];
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['product_description'] = productDescription;
    data['created_at'] = createdAt;
    if (variants != null) {
      data['variants'] = variants!.toJson();
    }
    data['product_status'] = productStatus;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['product_title'] = productTitle;
    data['product_reward_points'] = productRewardPoints;
    data['product_id'] = productId;
    data['product_image'] = productImage;
    data['tags'] = tags;
    return data;
  }
}

class Variants {
  Variants();

  Variants.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_path'] = imagePath;
    data['image_id'] = imageId;
    return data;
  }
}
