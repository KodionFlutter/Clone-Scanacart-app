class TopUSStateModel {
  //{"total":4139,"cnt":45,"state":"Alabama","percent_cnt":" 1.1%"}
  int? cnt;
  int? total;
  String? stateName;
  String? percentCnt;

  TopUSStateModel({this.cnt, this.stateName, this.percentCnt, this.total});

  TopUSStateModel.fromJson(Map<String, dynamic> json) {
    cnt = json['cnt'];
    total = json['total'];
    stateName = json['state'];
    percentCnt = json['percent_cnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cnt'] = cnt;
    data['total'] = total;
    data['state'] = stateName;
    data['percent_cnt'] = percentCnt;
    return data;
  }
}
