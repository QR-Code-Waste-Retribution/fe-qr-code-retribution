import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/models/form/user_form.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/user/user.dart';
import 'package:qr_code_app/models/user/user_pagination.dart';
import 'package:qr_code_app/services/repositories/user_repositories.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class UsersProvider extends GetxController {
  final UserRepositories _userRepositories = UserRepositories();

  final box = GetStorage();

  final RxList<User> userList = <User>[User()].obs;

  final Rx<UsersPagination> usersPagination = UsersPagination(records: []).obs;

  List<User>? get getUsersPaginationRecords => usersPagination.value.records;

  Links? get getUsersPaginationLinks => usersPagination.value.links;

  Meta? get getUsersPaginationMeta => usersPagination.value.meta;

  List<User> get getUserList => userList;

  Rx<User> user = User().obs;

  RxBool isLoading = false.obs;

  Future<void> getAllMasyarakatBySubDistrictId(
      {required int? subDistrictId, required int pemungutId}) async {
    try {
      ResponseAPI response = await _userRepositories.getAllUserMasyarakat(
        pemungutId: pemungutId,
        subDistrictId: subDistrictId!,
      );
      
      usersPagination.value = UsersPagination.fromJson(response.data);

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

  Future<void> storeRegisterUser({required UserForm userForm}) async {
    try {
      ResponseAPI response =
          await _userRepositories.registerUser(userForm: userForm);

      user.value = User.fromJson(response.data);

      Get.snackbar(
        "Success",
        response.message,
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 5,
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

  Future<void> changeStatusMasyarakatSelected({required int userId}) async {
    try {
      ResponseAPI response = await _userRepositories
          .changeStatusSelectedMasyarakat(userId: userId);

      Get.snackbar(
        "Success",
        response.message,
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 5,
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
