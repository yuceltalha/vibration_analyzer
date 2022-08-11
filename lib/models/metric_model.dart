class DataModel {
  double? x;
  double? y;
  double? z;

  DataModel({this.x, this.y, this.z});

  DataModel.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
    z = json['z'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['x'] = x;
    data['y'] = y;
    data['z'] = z;
    return data;
  }
}

class FeedbackForm {
  double x;
  double y;
  double z;
  

  FeedbackForm(this.x, this.y, this.z);

    factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm(json['x'],json['y'],json['z']);
  }
  

  // Method to make GET parameters.
  Map toJson() => {
        'x': x,
        'y': y,
        'z': z,
      };
}
