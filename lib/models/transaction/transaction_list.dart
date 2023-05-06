import 'package:qr_code_app/models/transaction/transaction.dart';

class TransactionList {
  List<Transaction>? transaction;
  int? totalAmount;

  TransactionList({this.transaction, this.totalAmount});

  TransactionList.fromJson(Map<String, dynamic> json) {
    if (json['transaction'] != null) {
      transaction = <Transaction>[];
      json['transaction'].forEach((v) {
        transaction!.add(Transaction.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transaction != null) {
      data['transaction'] = transaction!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = totalAmount;

    return data;
  }
}
