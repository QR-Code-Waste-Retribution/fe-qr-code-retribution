import 'package:qr_code_app/models/timestamp.dart';
import 'package:qr_code_app/models/district.dart';

class Category {
  late final int id;
  late final String name;
  late final String description;
  late final int price;
  late final String status;
  late final String type;
  late final int parentId;
  late final District district;
  late final TimeStamp createdAt;
  late final TimeStamp updatedAt;

  Category(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.status,
      required this.type,
      required this.parentId,
      required this.district,
      required this.createdAt,
      required this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    status = json['status'];
    type = json['type'];
    parentId = json['parent_id'];
    district = (json['district'] != null
        ? District.fromJson(json['district'])
        : null)!;
    createdAt = (json['created_at'] != null
        ? TimeStamp.fromJson(json['created_at'])
        : null)!;
    updatedAt = (json['updated_at'] != null
        ? TimeStamp.fromJson(json['updated_at'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['status'] = status;
    data['type'] = type;
    data['parent_id'] = parentId;
    data['district'] = district.toJson();
    data['created_at'] = createdAt.toJson();
    data['updated_at'] = updatedAt.toJson();
    return data;
  }
}