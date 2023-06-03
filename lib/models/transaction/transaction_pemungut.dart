import 'package:qr_code_app/models/price.dart';
import 'package:qr_code_app/models/timestamp.dart';
import 'package:qr_code_app/models/transaction/deposit_calculation.dart';

class TransactionPemungut {
  List<Deposits>? deposits;
  DepositCalculation? depositCalculation;
  String? depositArreas;

  TransactionPemungut({this.deposits, this.depositArreas, this.depositCalculation});

  TransactionPemungut.fromJson(Map<String, dynamic> json) {
    if (json['deposits'] != null) {
      deposits = <Deposits>[];
      json['deposits'].forEach((v) {
        deposits!.add(Deposits.fromJson(v));
      });
    }
    depositCalculation = json['deposit_status'] != null
        ? DepositCalculation.fromJson(json['deposit_status'])
        : null;
    depositArreas = json['deposit_arreas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (deposits != null) {
      data['deposits'] = deposits!.map((v) => v.toJson()).toList();
    }
    if (depositCalculation != null) {
      data['deposit_status'] = depositCalculation!.toJson();
    }
    data['deposit_arreas'] = depositArreas;
    return data;
  }
}

class Deposits {
  Price? price;
  TimeStamp? date;
  int? status;

  Deposits({this.price, this.date, this.status});

  Deposits.fromJson(Map<String, dynamic> json) {
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    date = json['date'] != null ? TimeStamp.fromJson(json['date']) : null;
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
