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
        data!.add( Data.fromJson(v));
      });
    }
    totalProductsCount = json['totalProductsCount'];
    totalPointsUsed = json['total_points_used'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalProductsCount'] = totalProductsCount;
    data['total_points_used'] = totalPointsUsed;
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
        orderitem!.add(Orderitem.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_points'] = totalPoints;
    data['order_date'] = orderDate;
    data['zip_code'] = zipCode;
    data['state'] = state;
    if (orderitem != null) {
      data['orderitem'] = orderitem!.map((v) => v.toJson()).toList();
    }
    data['email'] = email;
    data['shipping_id'] = shippingId;
    data['customer_notes'] = customerNotes;
    data['name'] = name;
    data['order_id'] = orderId;
    data['city'] = city;
    data['country'] = country;
    data['client_notes'] = clientNotes;
    data['address'] = address;
    data['order_status'] = orderStatus;
    data['order_item_id'] = orderItemId;
    data['phone_number'] = phoneNumber;
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
        productName!.add( ProductName.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_variants'] = productVariants;
    data['quantity'] = quantity;
    data['points_used'] = pointsUsed;
    data['product_id'] = productId;
    if (productName != null) {
      data['product_name'] = productName!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_title'] =productTitle;
    return data;
  }
}
