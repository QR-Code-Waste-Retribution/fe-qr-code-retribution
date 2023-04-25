import 'package:qr_code_app/models/invoice_model.dart';
import 'package:qr_code_app/models/transaction/transaction.dart';

class TransactionInvoice {
  Transaction? transaction;
  List<Invoice>? invoice;

  TransactionInvoice({this.transaction, this.invoice});

  TransactionInvoice.fromJson(Map<String, dynamic> json) {
    transaction = json['transaction'] != null
        ? Transaction.fromJson(json['transaction'])
        : null;
    if (json['invoice'] != null) {
      invoice = <Invoice>[];
      json['invoice'].forEach((v) {
        invoice!.add(Invoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    if (invoice != null) {
      data['invoice'] = invoice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

