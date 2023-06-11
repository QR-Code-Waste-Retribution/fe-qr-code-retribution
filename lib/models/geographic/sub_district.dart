class SubDistrict {
  SubDistrict({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  SubDistrict.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class ListSubDistrict {
  List<SubDistrict>? subDistricts;

  ListSubDistrict({this.subDistricts});

  ListSubDistrict.fromJson(Map<String, dynamic> json) {
    if (json['sub_districts'] != null) {
      subDistricts = <SubDistrict>[];
      json['sub_districts'].forEach((v) {
        subDistricts!.add(SubDistrict.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subDistricts != null) {
      data['sub_districts'] = subDistricts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
