class CommonModel {
  String? status;
  String? message;

  CommonModel({this.status, this.message});

  factory CommonModel.fromJson(Map<String, dynamic> map) =>
      CommonModel(status: map['status'], message: map['message']);
}