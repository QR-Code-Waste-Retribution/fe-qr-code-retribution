
class Method {
  String? payments;
  String? type;

  Method({this.payments, this.type});

  Method.fromJson(Map<String, dynamic> json) {
    payments = json['payments'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payments'] = payments;
    data['type'] = type;
    return data;
  }
}