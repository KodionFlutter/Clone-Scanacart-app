class CategoryDetailsModel {
  CategoryDetailsModel({
     this.success,
     this.data,
  });
    bool? success;
    Data? data;

  CategoryDetailsModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data?.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.categoryId,
    required this.createdAt,
    required this.variants,
    required this.productId,
    required this.productImage,
    required this.productDescription,
    required this.rewardPoints,
    required this.productStatus,
    required this.clientId,
    required this.images,
    required this.productTitle,
    required this.variantsData,
    required this.tags,
  });
  late final String categoryId;
  late final String createdAt;
  late final Variants variants;
  late final int productId;
  late final String productImage;
  late final String productDescription;
  late final int rewardPoints;
  late final String productStatus;
  late final String clientId;
  late final List<Images> images;
  late final String productTitle;
  late final List<dynamic> variantsData;
  late final String tags;

  Data.fromJson(Map<String, dynamic> json){
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    variants = Variants.fromJson(json['variants']);
    productId = json['product_id'];
    productImage = json['product_image'];
    productDescription = json['product_description'];
    rewardPoints = json['reward_points'];
    productStatus = json['product_status'];
    clientId = json['client_id'];
    images = List.from(json['images']).map((e)=>Images.fromJson(e)).toList();
    productTitle = json['product_title'];
    variantsData = List.castFrom<dynamic, dynamic>(json['variantsData']);
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['category_id'] = categoryId;
    _data['created_at'] = createdAt;
    _data['variants'] = variants.toJson();
    _data['product_id'] = productId;
    _data['product_image'] = productImage;
    _data['product_description'] = productDescription;
    _data['reward_points'] = rewardPoints;
    _data['product_status'] = productStatus;
    _data['client_id'] = clientId;
    _data['images'] = images.map((e)=>e.toJson()).toList();
    _data['product_title'] = productTitle;
    _data['variantsData'] = variantsData;
    _data['tags'] = tags;
    return _data;
  }
}

class Variants {
  Variants();

  Variants.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}

class Images {
  Images({
    required this.imagePath,
    required this.imageId,
  });
  late final String imagePath;
  late final int imageId;

  Images.fromJson(Map<String, dynamic> json){
    imagePath = json['image_path'];
    imageId = json['image_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image_path'] = imagePath;
    _data['image_id'] = imageId;
    return _data;
  }
}