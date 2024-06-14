class RewardModel {
  bool? success;
  RewardData? data;

  RewardModel({this.success, this.data});

  RewardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ?  RewardData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
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
        rewards!.add(Rewards.fromJson(v));
      });
    }
    customerName = json['customer_name'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rewards != null) {
      data['rewards'] = rewards!.map((v) => v.toJson()).toList();
    }
    data['customer_name'] = customerName;
    data['customer_id'] = customerId;
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
        cardDetail!.add( CardDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reward_points'] = rewardPoints;
    data['client_id'] = clientId;
    data['client_name'] = clientName;
    data['client_logo'] = clientLogo;
    if (cardDetail != null) {
      data['card_detail'] = cardDetail!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['card_text'] = cardText;
    data['max_range'] = maxRange;
    data['card_name'] = cardName;
    data['card_image'] = cardImage;
    data['min_range'] = minRange;
    return data;
  }
}
