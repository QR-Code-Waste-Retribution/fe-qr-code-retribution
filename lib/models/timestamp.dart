class TimeStamp {
  late final String date;
  late final String formatedDate;

  TimeStamp({required this.date, required this.formatedDate});

  TimeStamp.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    formatedDate = json['formated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['formated_date'] = formatedDate;
    return data;
  }
}