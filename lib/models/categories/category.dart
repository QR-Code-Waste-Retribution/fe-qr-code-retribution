import 'package:qr_code_app/models/timestamp.dart';
import 'package:qr_code_app/models/geographic/district.dart';

class Category {
  int? id;
  String? name;
  String? address;
  String? description;
  int? price;
  String? status;
  String? type;
  int? parentId;
  District? district;
  TimeStamp? createdAt;
  TimeStamp? updatedAt;

  Category(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.status,
      this.type,
      this.parentId,
      this.district,
      this.createdAt,
      this.updatedAt, this.address});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['description'] = description;
    data['price'] = price;
    data['status'] = status;
    data['type'] = type;
    data['parent_id'] = parentId;
    data['district'] = district?.toJson();
    data['created_at'] = createdAt?.toJson();
    data['updated_at'] = updatedAt?.toJson();
    return data;
  }
}