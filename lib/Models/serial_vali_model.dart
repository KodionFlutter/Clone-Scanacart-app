class SerialValiModel {
  final String? x;
  final double? y;

  SerialValiModel({this.x, this.y});

  factory SerialValiModel.fromJson(Map<String, dynamic> json) =>
      SerialValiModel(
        x: json['x'],
        y: json["y"],
      );
}
