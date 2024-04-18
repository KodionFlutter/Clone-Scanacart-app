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
        data!.add(new Data.fromJson(v));
      });
    }
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['category_name'] = this.categoryName;
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
    variants = json['variants'] != null
        ? new Variants.fromJson(json['variants'])
        : null;
    productStatus = json['product_status'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    productTitle = json['product_title'];
    productRewardPoints = json['product_reward_points'];
    productId = json['product_id'];
    productImage = json['product_image'];
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['product_description'] = this.productDescription;
    data['created_at'] = this.createdAt;
    if (this.variants != null) {
      data['variants'] = this.variants!.toJson();
    }
    data['product_status'] = this.productStatus;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['product_title'] = this.productTitle;
    data['product_reward_points'] = this.productRewardPoints;
    data['product_id'] = this.productId;
    data['product_image'] = this.productImage;
    data['tags'] = this.tags;
    return data;
  }
}

class Variants {
  Variants();

  Variants.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
