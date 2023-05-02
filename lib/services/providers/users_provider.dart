import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/user.dart';
import 'package:qr_code_app/services/repositories/user_repositories.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class UsersProvider extends GetxController {
  final UserRepositories _userRepositories = UserRepositories();

  final RxList<User> userList = <User>[].obs;

  List<User> get getUserList => userList;

  Future<void> getAllMasyarakatBySubDistrictId(
      {required int? subDistrictId}) async {
    try {
      ResponseAPI response =
          await _userRepositories.getAllUser(subDistrictId: subDistrictId!);

      userList.value = List<User>.from(
        response.data.map(
          (user) => User.fromJson(user),
        ),
      );

      update();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get all user : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }
}
