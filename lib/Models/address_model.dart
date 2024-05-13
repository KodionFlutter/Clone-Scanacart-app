class AddressModel {
  bool? success;
  List<Data>? data;

  AddressModel({this.success, this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =<String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? city;
  String? country;
  String? zipCode;
  String? address;
  String? state;
  int? shippingId;
  String? email;
  String? phoneNumber;
  String? name;

  Data(
      {this.city,
      this.country,
      this.zipCode,
      this.address,
      this.state,
      this.shippingId,
      this.email,
      this.phoneNumber,
      this.name});

  Data.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    zipCode = json['zip_code'];
    address = json['address'];
    state = json['state'];
    shippingId = json['shipping_id'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['country'] = country;
    data['zip_code'] = zipCode;
    data['address'] = address;
    data['state'] = state;
    data['shipping_id'] = shippingId;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['name'] = name;
    return data;
  }
}
