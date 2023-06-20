import 'package:qr_code_app/models/categories/category.dart';
import 'package:qr_code_app/models/invoice/invoice_model.dart';
import 'package:qr_code_app/models/price.dart';
import 'package:qr_code_app/models/timestamp.dart';
import 'package:qr_code_app/models/user/user.dart';

class Transaction {
  int? id;
  Price? price;
  String? status;
  String? date;
  String? type;
  String? referenceNumber;
  String? transactionNumber;
  User? user;
  int? pemungutId;
  Category? category;
  TimeStamp? createdAt;
  TimeStamp? updatedAt;
  List<Invoice>? invoice;

  Transaction(
      {this.id,
      this.price,
      this.status,
      this.date,
      this.type,
      this.referenceNumber,
      this.transactionNumber,
      this.user,
      this.pemungutId,
      this.category,
      this.createdAt,
      this.updatedAt,
      this.invoice});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    status = json['status'];
    date = json['date'];
    type = json['type'];
    referenceNumber = json['reference_number'];
    transactionNumber = json['transaction_number'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    pemungutId = json['pemungut_id'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    createdAt = json['created_at'] != null
        ? TimeStamp.fromJson(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? TimeStamp.fromJson(json['updated_at'])
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
    data['id'] = id;
    if (price != null) {
      data['price'] = price!.toJson();
    }
    data['status'] = status;
    data['date'] = date;
    data['type'] = type;
    data['reference_number'] = referenceNumber;
    data['transaction_number'] = transactionNumber;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['pemungut_id'] = pemungutId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (createdAt != null) {
      data['created_at'] = createdAt!.toJson();
    }
    if (updatedAt != null) {
      data['updated_at'] = updatedAt!.toJson();
    }
    if (invoice != null) {
      data['invoice'] = invoice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
