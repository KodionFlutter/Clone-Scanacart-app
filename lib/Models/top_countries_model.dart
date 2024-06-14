class TopCountriesModel {
  int? cnt;
  String? countryName;

  TopCountriesModel({this.cnt, this.countryName});

  TopCountriesModel.fromJson(Map<String, dynamic> json) {
    cnt = json['cnt'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cnt'] = this.cnt;
    data['country_name'] = this.countryName;
    return data;
  }
}
