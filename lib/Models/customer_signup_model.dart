class CustomerSignUpModel {
  String? message;
  bool? success;
  String? customerId;

  CustomerSignUpModel({this.message, this.success, this.customerId});

  CustomerSignUpModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    data['customer_id'] = this.customerId;
    return data;
  }
}
