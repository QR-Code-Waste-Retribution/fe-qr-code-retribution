class UserCategoriesForm {
  String? name;
  String? nik;
  String? phoneNumber;
  int? pemungutId;
  Categories? categories;

  UserCategoriesForm(
      {this.name,
      this.nik,
      this.phoneNumber,
      this.pemungutId,
      this.categories});

  UserCategoriesForm.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nik = json['nik'];
    phoneNumber = json['phoneNumber'];
    pemungutId = json['pemungut_id'];
    categories = json['categories'] != null
        ? Categories.fromJson(json['categories'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['nik'] = nik;
    data['phoneNumber'] = phoneNumber;
    data['pemungut_id'] = pemungutId;
    if (categories != null) {
      data['categories'] = categories!.toJson();
    }
    return data;
  }
}

class Categories {
  List<Meta>? delete;
  List<Meta>? insert;

  Categories({this.delete, this.insert});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['delete'] != null) {
      delete = <Meta>[];
      json['delete'].forEach((v) {
        delete!.add(Meta.fromJson(v));
      });
    }
    if (json['insert'] != null) {
      insert = <Meta>[];
      json['insert'].forEach((v) {
        insert!.add(Meta.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (delete != null) {
      data['delete'] = delete!.map((v) => v.toJson()).toList();
    }
    if (insert != null) {
      data['insert'] = insert!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? id;
  String? address;

  Meta({this.id, this.address});

  Meta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    return data;
  }
}
