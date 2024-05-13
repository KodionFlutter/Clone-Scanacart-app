class OrderModel {
  bool? success;
  List<Data>? data;
  int? orderCount;

  OrderModel({this.success, this.data, this.orderCount});

  OrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
    orderCount = json['order_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['order_count'] = this.orderCount;
    return data;
  }
}

class Data {
  String? cOMPANYNAME;
  int? tOTALPOINTS;
  int? oRDERID;
  String? oRDERDATE;
  int? clientId;
  String? aDDRESS;
  String? orderStatus;
  int? sHIPPINGID;
  String? pHONENUMBER;

  Data(
      {this.cOMPANYNAME,
      this.tOTALPOINTS,
      this.oRDERID,
      this.oRDERDATE,
      this.clientId,
      this.aDDRESS,
      this.orderStatus,
      this.sHIPPINGID,
      this.pHONENUMBER});

  Data.fromJson(Map<String, dynamic> json) {
    cOMPANYNAME = json['COMPANY_NAME'];
    tOTALPOINTS = json['TOTAL_POINTS'];
    oRDERID = json['ORDER_ID'];
    oRDERDATE = json['ORDER_DATE'];
    clientId = json['client_id'];
    aDDRESS = json['ADDRESS'];
    orderStatus = json['order_status'];
    sHIPPINGID = json['SHIPPING_ID'];
    pHONENUMBER = json['PHONE_NUMBER'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['COMPANY_NAME'] = this.cOMPANYNAME;
    data['TOTAL_POINTS'] = this.tOTALPOINTS;
    data['ORDER_ID'] = this.oRDERID;
    data['ORDER_DATE'] = this.oRDERDATE;
    data['client_id'] = this.clientId;
    data['ADDRESS'] = this.aDDRESS;
    data['order_status'] = this.orderStatus;
    data['SHIPPING_ID'] = this.sHIPPINGID;
    data['PHONE_NUMBER'] = this.pHONENUMBER;
    return data;
  }
}
