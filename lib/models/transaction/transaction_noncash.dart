import 'package:qr_code_app/models/transaction/method.dart';

class TransactionNonCash {
  List<LineItems>? lineItems;
  double? totalAmount;
  int? masyarakatId;
  int? pemungutId;
  int? categoryId;
  int? subDistrictId;
  String? type;
  Method? method;

  TransactionNonCash(
      {this.lineItems,
      this.totalAmount,
      this.masyarakatId,
      this.pemungutId,
      this.categoryId,
      this.subDistrictId,
      this.type,
      this.method});

  TransactionNonCash.fromJson(Map<String, dynamic> json) {
    if (json['line_items'] != null) {
      lineItems = <LineItems>[];
      json['line_items'].forEach((v) {
        lineItems!.add(LineItems.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    masyarakatId = json['masyarakat_id'];
    pemungutId = json['pemungut_id'];
    categoryId = json['category_id'];
    subDistrictId = json['sub_district_id'];
    type = json['type'];
    method =
        json['method'] != null ? Method.fromJson(json['method']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lineItems != null) {
      data['line_items'] = lineItems!.map((v) => v.toJson()).toList();
    }
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

class LineItems {
  int? invoiceId;
  String? name;
  int? quantity;
  int? price;

  LineItems({this.invoiceId, this.name, this.quantity, this.price});

  LineItems.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invoice_id'] = invoiceId;
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}
