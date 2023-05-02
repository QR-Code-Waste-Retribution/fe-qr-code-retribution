import 'package:qr_code_app/models/categories/category.dart';
import 'package:qr_code_app/models/timestamp.dart';
import 'package:qr_code_app/models/price/price.dart';
import 'package:qr_code_app/models/user/user.dart';

class InvoiceList {
  late final List<Invoice> invoice;
  late final User? user;

  InvoiceList({required this.invoice, this.user});

  InvoiceList.fromJson(Map<String, dynamic> json) {
    invoice = <Invoice>[];
    for (var v in json['invoice']) {
      invoice.add(Invoice.fromJson(v));
    }
    user = (json['user'] != null ? User.fromJson(json['user']) : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> invoice = <String, dynamic>{};
    invoice['invoice'] = this.invoice.map((v) => v.toJson()).toList();
    invoice['user'] = user;
    return invoice;
  }
}

class Invoice {
  late final int id;
  late final int categoryId;
  late final Price price;
  late final int userId;
  late final int status;
  late final Category category;
  late final String address;
  late final String subDistrictName;
  late final String date;
  late final List<int> variants;
  late final TimeStamp createdAt;
  late final TimeStamp updatedAt;

  Invoice(
      {required this.id,
      required this.categoryId,
      required this.price,
      required this.userId,
      required this.status,
      required this.category,
      required this.address,
      required this.subDistrictName,
      required this.date,
      required this.variants,
      required this.createdAt,
      required this.updatedAt});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    price = (json['price'] != null ? Price.fromJson(json['price']) : null)!;
    userId = json['user_id'];
    status = json['status'];
    category = (json['category'] != null
        ? Category.fromJson(json['category'])
        : null)!;
    address = json['address'];
    subDistrictName = json['sub_district_name'];
    date = json['date'];
    variants = json['variants'].cast<int>();
    createdAt = (json['created_at'] != null
        ? TimeStamp.fromJson(json['created_at'])
        : null)!;
    updatedAt = (json['updated_at'] != null
        ? TimeStamp.fromJson(json['updated_at'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> invoice = <String, dynamic>{};
    invoice['id'] = id;
    invoice['category_id'] = categoryId;
    invoice['price'] = price.toJson();
    invoice['user_id'] = userId;
    invoice['status'] = status;
    invoice['category'] = category.toJson();
    invoice['address'] = address;
    invoice['sub_district_name'] = subDistrictName;
    invoice['date'] = date;
    invoice['variants'] = variants;
    invoice['created_at'] = createdAt.toJson();
    invoice['updated_at'] = updatedAt.toJson();
    return invoice;
  }
}
