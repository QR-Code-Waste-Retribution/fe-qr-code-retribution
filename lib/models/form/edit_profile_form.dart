class EditProfileForm {
  final String phoneNumber;
  final String address;

  EditProfileForm({
    required this.phoneNumber,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    return data;
  }
}
