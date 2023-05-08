import 'package:qr_code_app/models/price.dart';

class TransactionPemungut {
  List<Deposit>? deposit;

  TransactionPemungut({this.deposit});

  TransactionPemungut.fromJson(Map<String, dynamic> json) {
    if (json['deposit'] != null) {
      deposit = <Deposit>[];
      json['deposit'].forEach((v) {
        deposit!.add(Deposit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (deposit != null) {
      data['deposit'] = deposit!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Deposit {
  Price? price;
  String? date;
  int? status;

  Deposit({this.price, this.date, this.status});

  Deposit.fromJson(Map<String, dynamic> json) {
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (price != null) {
      data['price'] = price!.toJson();
    }
    data['date'] = date;
    data['status'] = status;
    return data;
  }
}
