import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/molekuls/snackbar/snackbar.dart';
import 'package:qr_code_app/exceptions/api_exception.dart';
import 'package:qr_code_app/models/form/user_form.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/user/user.dart';
import 'package:qr_code_app/routes/init.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/repositories/user_repositories.dart';
import 'package:qr_code_app/utils/logger.dart';

class AddUserProvider extends GetxController {
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  final UserRepositories _userRepositories = UserRepositories();

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> usernameController = TextEditingController().obs;
  Rx<TextEditingController> nikController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> categoryController = TextEditingController().obs;
  Rx<TextEditingController> subDistrictController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;

  RxString dropdownCategoryValue = '1'.obs;
  RxString dropdownSubDistrictValue = ''.obs;

  String get getDropdownCategoryValue => dropdownCategoryValue.string;
  String get getDropdownSubDistrictValue => dropdownSubDistrictValue.string;

  RxList<TextEditingController> textInputControllers =
      <TextEditingController>[].obs;

  RxMap<String, String> errorMessages = <String, String>{
    'name': '',
    'username': '',
    'email': '',
    'nik': '',
    'phoneNumber': '',
    'district_id': '',
    'sub_district_id': '',
    'category_id': '',
    'address': '',
    'pemungut_id': '',
  }.obs;

  Map<String, String> get getErrorMessages => errorMessages;

  Rx<User> user = User().obs;

  void onChangeInputName() {
    if (nameController.value.text == '') {
      errorMessages['name'] = "Input nama harus diisi";
    } else {
      errorMessages['name'] = "";
    }
  }

  void onChangeInputUsername() {
    if (usernameController.value.text == '') {
      errorMessages['username'] = "Input username harus diisi";
    } else {
      errorMessages['username'] = "";
    }
  }

  void onChangeInputNik() {}

  void onChangeInputEmail() {
    if (emailController.value.text == '') {
      errorMessages['email'] = "Input email harus diisi";
    } else {
      errorMessages['email'] = "";
    }
  }

  void onChangeInputAddress() {
    if (addressController.value.text == '') {
      errorMessages['address'] = "Input alamat harus diisi";
    } else {
      errorMessages['address'] = "";
    }
  }

  void onChangePhoneNumber() {
    if (phoneNumberController.value.text == '') {
      errorMessages['phoneNumber'] = "Input nomor telepon harus diisi";
    } else {
      errorMessages['phoneNumber'] = "";
    }
  }

  @override
  void onInit() {
    super.onInit();
    textInputControllers.addAll([
      nameController.value,
      usernameController.value,
      nikController.value,
      phoneNumberController.value,
      categoryController.value,
      subDistrictController.value,
      addressController.value,
      emailController.value,
    ]);
  }

  void submit() {
    UserForm userForm = UserForm(
      name: nameController.value.text,
      nik: nikController.value.text,
      email: emailController.value.text,
      username: usernameController.value.text,
      gender: "Laki-Laki",
      phoneNumber: phoneNumberController.value.text,
      category: int.parse(dropdownCategoryValue.value),
      address: addressController.value.text,
      districtId: _authProvider.districtId!,
      subDistrictId: int.parse(dropdownSubDistrictValue.value),
      pemungutId: _authProvider.getUserId!,
    );

    storeRegisterUser(userForm: userForm);
  }

  void clearInput() {
    for (var controller in textInputControllers) {
      controller.clear();
    }
  }

  Future<void> storeRegisterUser({required UserForm userForm}) async {
    try {
      ResponseAPI response =
          await _userRepositories.registerUser(userForm: userForm);

      user.value = User.fromJson(response.data);

      SnackBarCustom.success(message: response.message);

      clearInput();
      Get.toNamed(Pages.homePage);

      update();
    } on ApiException catch (e) {
      if (e.statusCode == 422) {
        e.responseAPI?.data.forEach((key, value) {
          errorMessages[key] = value;
        });
        SnackBarCustom.error(message: "Masukkan data yang valid!!");
      } else {
        SnackBarCustom.error(message: e.responseAPI!.message);
      }
      update();
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var controller in textInputControllers) {
      controller.dispose();
    }
  }
}
