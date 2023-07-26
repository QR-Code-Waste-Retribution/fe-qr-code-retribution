import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/components/molekuls/snackbar/snackbar.dart';
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

  int get getCurrentPage => getUsersPaginationMeta!.currentPage!;
  int get getLastPage => getUsersPaginationMeta!.lastPage!;

  List<User> get getUserList => userList;

  Rx<User> user = User().obs;

  RxBool isLoading = false.obs;

  RxBool isSwitched = false.obs;

  RxList<bool> isSwitchedList = <bool>[].obs;

  Rx<TextEditingController> searchController = TextEditingController().obs;

  int getPreviousPage() {
    return getCurrentPage - 1 == 0 ? 1 : getCurrentPage - 1;
  }

  int getNextPage() {
    return getCurrentPage + 1 > getLastPage ? getLastPage : getCurrentPage + 1;
  }

  void initSwitchedList() {
    isSwitchedList.value = [];
    for (var index = 0; index < getUsersPaginationRecords!.length; index++) {
      var item = getUsersPaginationRecords![index];
      isSwitchedList.add(item.accountStatus!);
    }
    update();
  }

  void searchMasyarakat({required int pemungutId, int page = 1}) async {
    await getAllMasyarakatBySubDistrictId(
      pemungutId: pemungutId,
      page: page,
      search: searchController.value.text,
    );
  }

  Future<void> getAllMasyarakatBySubDistrictId(
      {required int pemungutId, int page = 1, String search = ''}) async {
    try {
      ResponseAPI response = await _userRepositories.getAllUserMasyarakat(
        pemungutId: pemungutId,
        page: page,
        search: search,
      );

      usersPagination.value = UsersPagination.fromJson(response.data);
      initSwitchedList();
      update();
    } catch (e) {
      SnackBarCustom.error(message: e.toString());
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
}
