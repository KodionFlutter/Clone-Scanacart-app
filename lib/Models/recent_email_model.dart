class RecentEmailModel {
  bool? success;
  List<RecentEmailList>? recentEmailList;

  RecentEmailModel({this.success, this.recentEmailList});

  RecentEmailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['recentEmailList'] != null) {
      recentEmailList = <RecentEmailList>[];
      json['recentEmailList'].forEach((v) {
        recentEmailList!.add(new RecentEmailList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.recentEmailList != null) {
      data['recentEmailList'] =
          this.recentEmailList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecentEmailList {
  String? createDt;
  String? emailTimeDisplay;
  String? emailAddr;

  RecentEmailList({this.createDt, this.emailTimeDisplay, this.emailAddr});

  RecentEmailList.fromJson(Map<String, dynamic> json) {
    createDt = json['create_dt'];
    emailTimeDisplay = json['email_time_display'];
    emailAddr = json['email_addr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_dt'] = this.createDt;
    data['email_time_display'] = this.emailTimeDisplay;
    data['email_addr'] = this.emailAddr;
    return data;
  }
}
