class TransactionStore {
  List<int>? invoiceId;
  int? totalAmount;
  int? masyarakatId;
  int? pemungutId;
  int? categoryId;
  int? subDistrictId;
  String? type;
  Method? method;

  TransactionStore(
      {this.invoiceId,
      this.totalAmount,
      this.masyarakatId,
      this.pemungutId,
      this.categoryId,
      this.subDistrictId,
      this.type,
      this.method});

  TransactionStore.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'].cast<int>();
    totalAmount = json['total_amount'];
    masyarakatId = json['masyarakat_id'];
    pemungutId = json['pemungut_id'];
    categoryId = json['category_id'];
    subDistrictId = json['sub_district_id'];
    type = json['type'];
    method = json['method'] != null ? Method.fromJson(json['method']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invoice_id'] = invoiceId;
    data['total_amount'] = totalAmount;
    data['masyarakat_id'] = masyarakatId;
    data['pemungut_id'] = pemungutId;
    data['category_id'] = categoryId;
    data['sub_district_id'] = subDistrictId;
    data['type'] = type;
    if (method != null) {
      data['method'] = method!.toJson();
    }
    return data;
  }
}

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
