class SerialValidationModel {
  final String? label;
  final double? values;

  SerialValidationModel({this.label, this.values});

  factory SerialValidationModel.fromJson(Map<String, dynamic> json) =>
      SerialValidationModel(
        label: json['label'],
        values: json["values"],
      );
}
