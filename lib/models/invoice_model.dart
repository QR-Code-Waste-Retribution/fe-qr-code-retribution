import 'package:qr_code_app/models/category.dart';
import 'package:qr_code_app/models/timestamp.dart';
import 'package:qr_code_app/models/price.dart';
import 'package:qr_code_app/models/user.dart';

class InvoiceList {
  late final List<Invoice> data;
  late final User? user;

  InvoiceList({required this.data, this.user});

  InvoiceList.fromJson(Map<String, dynamic> json) {
    data = <Invoice>[];
    for (var v in json['invoice']) {
      data.add(Invoice.fromJson(v));
    }
    user = (json['user'] != null
        ? User.fromJson(json['user'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data.map((v) => v.toJson()).toList();
    data['user'] = user;
    return data;
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
    createdAt = (json['created_at'] != null
        ? TimeStamp.fromJson(json['created_at'])
        : null)!;
    updatedAt = (json['updated_at'] != null
        ? TimeStamp.fromJson(json['updated_at'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['price'] = price.toJson();
    data['user_id'] = userId;
    data['status'] = status;
    data['category'] = category.toJson();
    data['address'] = address;
    data['sub_district_name'] = subDistrictName;
    data['date'] = date;
    data['created_at'] = createdAt.toJson();
    data['updated_at'] = updatedAt.toJson();
    return data;
  }
}
