class EmployeeDataModel {
  int? rewards;
  List<String>? productImages;
  String? activityLocId;
  String? itemImage;
  String? largeLogo;
  String? shipTo;
  String? activityId;
  String? client;
  String? logoPath;
  int? rewardsActive;
  String? code;
  int? serialNum;
  String? videoUrl;
  int? clientId;
  int? labelPasswordId;
  int? is360;
  String? getAllClientLabResults;
  String? clientURL;
  String? itemName;

  EmployeeDataModel(
      {this.rewards,
        this.productImages,
        this.activityLocId,
        this.itemImage,
        this.largeLogo,
        this.shipTo,
        this.activityId,
        this.client,
        this.logoPath,
        this.rewardsActive,
        this.code,
        this.serialNum,
        this.videoUrl,
        this.clientId,
        this.labelPasswordId,
        this.is360,
        this.getAllClientLabResults,
        this.clientURL,
        this.itemName});

  EmployeeDataModel.fromJson(Map<String, dynamic> json) {
    rewards = json['rewards'];
    productImages = json['productImages'].cast<String>();
    activityLocId = json['activity_loc_id'];
    itemImage = json['itemImage'];
    largeLogo = json['large_logo'];
    shipTo = json['shipTo'];
    activityId = json['activity_id'];
    client = json['client'];
    logoPath = json['logo_path'];
    rewardsActive = json['rewards_active'];
    code = json['code'];
    serialNum = json['serial_num'];
    videoUrl = json['video_url'];
    clientId = json['client_id'];
    labelPasswordId = json['label_password_id'];
    is360 = json['is_360'];
    getAllClientLabResults = json['getAllClientLabResults'];
    clientURL = json['clientURL'];
    itemName = json['itemName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rewards'] = rewards;
    data['productImages'] = productImages;
    data['activity_loc_id'] = activityLocId;
    data['itemImage'] = itemImage;
    data['large_logo'] = largeLogo;
    data['shipTo'] = shipTo;
    data['activity_id'] = activityId;
    data['client'] = client;
    data['logo_path'] = logoPath;
    data['rewards_active'] = rewardsActive;
    data['code'] = code;
    data['serial_num'] = serialNum;
    data['video_url'] = videoUrl;
    data['client_id'] = clientId;
    data['label_password_id'] = labelPasswordId;
    data['is_360'] = is360;
    data['getAllClientLabResults'] = getAllClientLabResults;
    data['clientURL'] = clientURL;
    data['itemName'] = itemName;
    return data;
  }
}
