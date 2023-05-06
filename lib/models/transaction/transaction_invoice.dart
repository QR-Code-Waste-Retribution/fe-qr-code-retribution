import 'package:qr_code_app/models/invoice/invoice_store.dart';
import 'package:qr_code_app/models/transaction/transaction.dart';

class TransactionInvoice {
  Transaction? transaction;
  late List<InvoiceStore>? invoice;

  TransactionInvoice({this.transaction, required this.invoice});

  TransactionInvoice.fromJson(Map<String, dynamic> json) {
    transaction = json['transaction'] != null
        ? Transaction.fromJson(json['transaction'])
        : null;
    if (json['invoice'] != null) {
      invoice = <InvoiceStore>[];
      json['invoice'].forEach((v) {
        invoice?.add(InvoiceStore.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    if (invoice != null) {
      data['invoice'] = invoice?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

