class UserForm {
  final String name;
  final String username;
  final String? nik;
  final String phoneNumber;
  final int category;
  final int subDistrictId;
  final String address;

  UserForm({
    required this.name,
    required this.username,
    this.nik,
    required this.phoneNumber,
    required this.category,
    required this.subDistrictId,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
