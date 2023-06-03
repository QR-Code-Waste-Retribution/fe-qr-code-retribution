import 'package:qr_code_app/models/price.dart';
import 'package:qr_code_app/models/timestamp.dart';

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
  TimeStamp? date;
  int? status;

  Deposit({this.price, this.date, this.status});

  Deposit.fromJson(Map<String, dynamic> json) {
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    date = json['date'] != null
        ? TimeStamp.fromJson(json['date'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (price != null) {
      data['price'] = price!.toJson();
    }
    if (date != null) {
      data['date'] = date!.toJson();
    }
    data['status'] = status;
    return data;
  }
}
