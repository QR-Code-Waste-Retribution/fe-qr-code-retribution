import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/form/edit_user_form.dart';
import 'package:qr_code_app/models/form/user_form.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/user/user.dart';
import 'package:qr_code_app/services/repositories/user_repositories.dart';
import 'package:qr_code_app/utils/logger.dart';

class EditUserProvider extends GetxController {
  final UserRepositories _userRepositories = UserRepositories();
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> nikController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> subDistrictController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;

  RxList<String> dropdownCategoriesValues = <String>[].obs;
  RxList<String> dropdownSubDistrictsValues = <String>[].obs;

  RxList<TextEditingController> listAddressTextController =
      <TextEditingController>[].obs;

  List<TextEditingController> get getListAddressController =>
      listAddressTextController;

  List<String> get getDropdownCategoriesValues => dropdownCategoriesValues;
  List<String> get getDropdownSubDistrictsValues => dropdownSubDistrictsValues;

  RxString dropdownSubDistrictValue = ''.obs;

  String get getDropdownSubDistrictValue => dropdownSubDistrictValue.value;

  Rx<User> user = User().obs;

  final List<TextEditingController> textInputControllers = [];

  void addNewCategoryInput({required String newValue}) {
    dropdownCategoriesValues.add(newValue);
    listAddressTextController.add(TextEditingController());
    update();
    // logger.d(newValue);
  }

  void clearInput() {
    dropdownCategoriesValues.value = <String>[];
    dropdownSubDistrictsValues.value = <String>[];
    listAddressTextController.value = [TextEditingController()];
    for (var controller in textInputControllers) {
      controller.clear();
    }
    update();
  }

  void back() {
    clearInput();
    Get.back();
  }

  void onSubmit() {
    List<Categories> categories = [];

    for (var i = 0; i < dropdownCategoriesValues.length; i++) {
      categories.add(
        Categories(
          id: int.parse(dropdownCategoriesValues[i]),
          address: listAddressTextController[i].text,
        ),
      );
    }

    UserEditForm userEditForm = UserEditForm(
      name: nameController.value.text,
      nik: nikController.value.text,
      phoneNumber: phoneNumberController.value.text,
      categories: categories,
    );

    logger.d(userEditForm.toJson());
  }

  Future<void> getDetailMasyarakat({required int userId}) async {
    try {
      ResponseAPI response = await _userRepositories.getDetailMasyarakat(
        userId: userId,
      );

      user.value = User.fromJson(response.data);
      fillInput();
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

  void fillInput() {
    nameController.value.text = user.value.name!;
    nikController.value.text = user.value.nik!;
    phoneNumberController.value.text = user.value.phoneNumber!;
    dropdownSubDistrictValue.value = user.value.district!.id.toString();

    for (var category in user.value.category!) {
      dropdownCategoriesValues.add(category.id.toString());
      var addressInput = TextEditingController();
      addressInput.text = category.address!;
      listAddressTextController.add(addressInput);
    }
  }

  @override
  void onInit() {
    super.onInit();
    textInputControllers.addAll([
      nameController.value,
      nikController.value,
      phoneNumberController.value,
      subDistrictController.value,
      addressController.value,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    for (var controller in textInputControllers) {
      controller.dispose();
    }
  }
}
