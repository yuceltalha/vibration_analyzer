

class FeedbackForm {
  String x;
  String y;
  String z;


  FeedbackForm(this.x, this.y, this.z);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm("${json['x']}", "${json['y']}",
        "${json['z']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'x': x,
        'y': y,
        'z': z,
      };
}
