class CustomerSignUpModel {
  String? message;
  bool? success;
  var customerId;

  CustomerSignUpModel({this.message, this.success, this.customerId});

  CustomerSignUpModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    data['customer_id'] = customerId;
    return data;
  }
}
