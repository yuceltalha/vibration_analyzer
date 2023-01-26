class DateEntity {
  final String date;


  DateEntity({
    required this.date,

  });

  factory DateEntity.fromSheets(List<String> input) =>
      DateEntity(date:input.isEmpty || input==null ? "null" : input[0]);
}