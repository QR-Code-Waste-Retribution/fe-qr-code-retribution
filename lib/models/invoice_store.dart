import 'package:qr_code_app/models/category.dart';
import 'package:qr_code_app/models/price.dart';
import 'package:qr_code_app/models/user.dart';

class InvoiceStore {
  User? user;
  Category? category;
  Price? price;
  int? status;

  InvoiceStore({this.user, this.category, this.price, this.status});

  InvoiceStore.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (price != null) {
      data['price'] = price!.toJson();
    }
    data['status'] = status;
    return data;
  }
}