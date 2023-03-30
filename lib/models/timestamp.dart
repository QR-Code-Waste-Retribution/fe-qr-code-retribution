class TimeStamp {
  late final String date;
  late final String formatedDate;

  TimeStamp({required this.date, required this.formatedDate});

  TimeStamp.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    formatedDate = json['formated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['formated_date'] = this.formatedDate;
    return data;
  }
}