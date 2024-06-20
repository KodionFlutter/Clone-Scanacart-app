class TopCountriesModel {
  int? cnt;
  String? countryName;

  TopCountriesModel({this.cnt, this.countryName});

  TopCountriesModel.fromJson(Map<String, dynamic> json) {
    cnt = json['cnt'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cnt'] = cnt;
    data['country_name'] = countryName;
    return data;
  }
}
