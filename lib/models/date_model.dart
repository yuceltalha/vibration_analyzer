class DateForm {
  String date;


  DateForm(this.date);

  factory DateForm.fromJson(dynamic json) {
    return DateForm("${json['date']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'date': date,
      };
}