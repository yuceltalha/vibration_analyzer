// To parse this JSON data, do
//
//     final metricModel = metricModelFromJson(jsonString);

import 'dart:convert';

List<MetricModel> metricModelFromJson(String str) => List<MetricModel>.from(
    json.decode(str).map((x) => MetricModel.fromJson(x)));

String metricModelToJson(List<MetricModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MetricModel {
  MetricModel({
    this.x,
    this.y,
    this.z,
  });

  double? x;
  double? y;
  double? z;

  factory MetricModel.fromJson(Map<String, dynamic> json) => MetricModel(
        x: json["x"] == null ? null : json["x"]!.toDouble(),
        y: json["y"] == null ? null : json["y"]!.toDouble(),
        z: json["z"] == null ? null : json["z"]!.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "x": x == null ? null : x!,
        "y": y == null ? null : y!,
        "z": z == null ? null : z!,
      };
}
