class ChangePasswordForm {
  final String? oldPassword;
  final String? email;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordForm({
    this.oldPassword,
    this.email,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['old_password'] = oldPassword;
    data['password'] = newPassword;
    data['email'] = email;
    data['password_confirmation'] = confirmPassword;
    return data;
  }
}
