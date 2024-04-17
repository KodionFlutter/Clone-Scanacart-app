class RewardModel {
  bool? success;
  RewardData? data;

  RewardModel({this.success, this.data});

  RewardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new RewardData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RewardData {
  List<Rewards>? rewards;
  String? customerName;
  int? customerId;

  RewardData({this.rewards, this.customerName, this.customerId});

  RewardData.fromJson(Map<String, dynamic> json) {
    if (json['rewards'] != null) {
      rewards = <Rewards>[];
      json['rewards'].forEach((v) {
        rewards!.add(new Rewards.fromJson(v));
      });
    }
    customerName = json['customer_name'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rewards != null) {
      data['rewards'] = this.rewards!.map((v) => v.toJson()).toList();
    }
    data['customer_name'] = this.customerName;
    data['customer_id'] = this.customerId;
    return data;
  }
}

class Rewards {
  int? rewardPoints;
  int? clientId;
  String? clientName;
  String? clientLogo;
  List<CardDetail>? cardDetail;

  Rewards(
      {this.rewardPoints,
        this.clientId,
        this.clientName,
        this.clientLogo,
        this.cardDetail});

  Rewards.fromJson(Map<String, dynamic> json) {
    rewardPoints = json['reward_points'];
    clientId = json['client_id'];
    clientName = json['client_name'];
    clientLogo = json['client_logo'];
    if (json['card_detail'] != null) {
      cardDetail = <CardDetail>[];
      json['card_detail'].forEach((v) {
        cardDetail!.add(new CardDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reward_points'] = this.rewardPoints;
    data['client_id'] = this.clientId;
    data['client_name'] = this.clientName;
    data['client_logo'] = this.clientLogo;
    if (this.cardDetail != null) {
      data['card_detail'] = this.cardDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardDetail {
  String? cardText;
  int? maxRange;
  String? cardName;
  String? cardImage;
  int? minRange;

  CardDetail(
      {this.cardText,
        this.maxRange,
        this.cardName,
        this.cardImage,
        this.minRange});

  CardDetail.fromJson(Map<String, dynamic> json) {
    cardText = json['card_text'];
    maxRange = json['max_range'];
    cardName = json['card_name'];
    cardImage = json['card_image'];
    minRange = json['min_range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_text'] = this.cardText;
    data['max_range'] = this.maxRange;
    data['card_name'] = this.cardName;
    data['card_image'] = this.cardImage;
    data['min_range'] = this.minRange;
    return data;
  }
}
