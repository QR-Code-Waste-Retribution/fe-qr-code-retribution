import 'package:qr_code_app/models/transaction/transaction.dart';

class TransactionList {
  List<Transaction>? transaction;

  TransactionList({this.transaction});

  TransactionList.fromJson(Map<String, dynamic> json) {
    if (json['transaction'] != null) {
      transaction = <Transaction>[];
      json['transaction'].forEach((v) {
        transaction!.add(Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transaction != null) {
      data['transaction'] = transaction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}