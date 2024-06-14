import 'package:flutter/material.dart';

class LabelValidationLocationModel {
  const LabelValidationLocationModel(
      {this.city,
      this.latitude,
      this.longitude,
      this.marker,
      this.color,
      this.percentage});

  final String? city;
  final double? latitude;
  final double? longitude;
  final int? marker;
  final Color? color;
  final String? percentage;

  factory LabelValidationLocationModel.fromJson(Map<String, dynamic> json) =>
      LabelValidationLocationModel(
        city: json['city'],
        latitude: json['latitude'],
        longitude: json['latitude'],
        marker: json['marker'],
        color: json['color'],
        percentage: json['percentage'],
      );
}
