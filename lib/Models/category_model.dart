class CategoryModel {
  bool? success;
  List<Data>? data;

  CategoryModel({this.success, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? categoryId;
  String? categoryImage;
  String? categoryDescription;
  String? categoryName;

  Data(
      {this.categoryId,
      this.categoryImage,
      this.categoryDescription,
      this.categoryName});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryImage = json['category_image'];
    categoryDescription = json['category_description'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_image'] = categoryImage;
    data['category_description'] = categoryDescription;
    data['category_name'] = categoryName;
    return data;
  }
}
