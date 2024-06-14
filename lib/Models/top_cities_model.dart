//{"city":"Atlanta","region_code":"GA","cnt":145,"country_code":"US"}
class TopCitiesModel {
  int? cnt;
  String? countryCode;
  String? city;
  String? regionCode;

  TopCitiesModel({this.cnt, this.countryCode, this.regionCode, this.city});

  TopCitiesModel.fromJson(Map<String, dynamic> json) {
    cnt = json['cnt'];
    countryCode = json['country_code'];
    city = json['city'];
    regionCode = json['region_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cnt'] = cnt;
    data['country_code'] = countryCode;
    data['city'] = city;
    data['region_code'] = regionCode;
    return data;
  }
}
