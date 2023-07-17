class ChangePasswordForm {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordForm({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['old_password'] = oldPassword;
    data['password'] = newPassword;
    data['password_confirmation'] = confirmPassword;
    return data;
  }
}
