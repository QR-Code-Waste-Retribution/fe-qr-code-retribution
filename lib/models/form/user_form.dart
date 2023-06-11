class UserForm {
  final String name;
  final String username;
  final String? nik;
  final String phoneNumber;
  final String gender;
  final int category;
  final int subDistrictId;
  final int districtId;
  final int pemungutId;
  final String address;

  UserForm({
    required this.name,
    required this.username,
    this.nik,
    required this.gender,
    required this.phoneNumber,
    required this.category,
    required this.subDistrictId,
    required this.districtId,
    required this.pemungutId,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['username'] = username;
    data['nik'] = nik;
    data['gender'] = gender;
    data['phoneNumber'] = phoneNumber;
    data['category_id'] = category;
    data['sub_district_id'] = subDistrictId;
    data['district_id'] = districtId;
    data['pemungut_id'] = pemungutId;
    data['address'] = address;
    return data;
  }
}
