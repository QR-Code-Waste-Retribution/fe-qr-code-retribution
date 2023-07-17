class UserEditForm {
  final String name;
  final String? nik;
  final String phoneNumber;
  final List<Categories> categories;

  UserEditForm({
    required this.name,
    this.nik,
    required this.phoneNumber,
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['nik'] = nik;
    data['phoneNumber'] = phoneNumber;
    data['categories'] = categories.map((v) => v.toJson()).toList();
    return data;
  }
}

class Categories {
  final int id;
  final String address;

  Categories({
    required this.id,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    return data;
  }
}
