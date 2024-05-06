class OrderDetailsModel {
  bool? success;
  List<Data>? data;
  int? totalProductsCount;
  int? totalPointsUsed;

  OrderDetailsModel(
      {this.success, this.data, this.totalProductsCount, this.totalPointsUsed});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    totalProductsCount = json['totalProductsCount'];
    totalPointsUsed = json['total_points_used'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalProductsCount'] = this.totalProductsCount;
    data['total_points_used'] = this.totalPointsUsed;
    return data;
  }
}

class Data {
  int? totalPoints;
  String? orderDate;
  String? zipCode;
  String? state;
  List<Orderitem>? orderitem;
  String? email;
  int? shippingId;
  String? customerNotes;
  String? name;
  int? orderId;
  String? city;
  String? country;
  String? clientNotes;
  String? address;
  String? orderStatus;
  int? orderItemId;
  String? phoneNumber;

  Data(
      {this.totalPoints,
      this.orderDate,
      this.zipCode,
      this.state,
      this.orderitem,
      this.email,
      this.shippingId,
      this.customerNotes,
      this.name,
      this.orderId,
      this.city,
      this.country,
      this.clientNotes,
      this.address,
      this.orderStatus,
      this.orderItemId,
      this.phoneNumber});

  Data.fromJson(Map<String, dynamic> json) {
    totalPoints = json['total_points'];
    orderDate = json['order_date'];
    zipCode = json['zip_code'];
    state = json['state'];
    if (json['orderitem'] != null) {
      orderitem = <Orderitem>[];
      json['orderitem'].forEach((v) {
        orderitem!.add(new Orderitem.fromJson(v));
      });
    }
    email = json['email'];
    shippingId = json['shipping_id'];
    customerNotes = json['customer_notes'];
    name = json['name'];
    orderId = json['order_id'];
    city = json['city'];
    country = json['country'];
    clientNotes = json['client_notes'];
    address = json['address'];
    orderStatus = json['order_status'];
    orderItemId = json['order_item_id'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_points'] = this.totalPoints;
    data['order_date'] = this.orderDate;
    data['zip_code'] = this.zipCode;
    data['state'] = this.state;
    if (this.orderitem != null) {
      data['orderitem'] = this.orderitem!.map((v) => v.toJson()).toList();
    }
    data['email'] = this.email;
    data['shipping_id'] = this.shippingId;
    data['customer_notes'] = this.customerNotes;
    data['name'] = this.name;
    data['order_id'] = this.orderId;
    data['city'] = this.city;
    data['country'] = this.country;
    data['client_notes'] = this.clientNotes;
    data['address'] = this.address;
    data['order_status'] = this.orderStatus;
    data['order_item_id'] = this.orderItemId;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}

class Orderitem {
  String? productVariants;
  int? quantity;
  int? pointsUsed;
  int? productId;
  List<ProductName>? productName;

  Orderitem(
      {this.productVariants,
      this.quantity,
      this.pointsUsed,
      this.productId,
      this.productName});

  Orderitem.fromJson(Map<String, dynamic> json) {
    productVariants = json['product_variants'];
    quantity = json['quantity'];
    pointsUsed = json['points_used'];
    productId = json['product_id'];
    if (json['product_name'] != null) {
      productName = <ProductName>[];
      json['product_name'].forEach((v) {
        productName!.add(new ProductName.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_variants'] = this.productVariants;
    data['quantity'] = this.quantity;
    data['points_used'] = this.pointsUsed;
    data['product_id'] = this.productId;
    if (this.productName != null) {
      data['product_name'] = this.productName!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductName {
  String? productTitle;

  ProductName({this.productTitle});

  ProductName.fromJson(Map<String, dynamic> json) {
    productTitle = json['product_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_title'] = this.productTitle;
    return data;
  }
}
