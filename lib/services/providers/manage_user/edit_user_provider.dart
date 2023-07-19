import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/molekuls/snackbar/snackbar.dart';
import 'package:qr_code_app/exceptions/api_exception.dart';
import 'package:qr_code_app/models/form/auth/user_categories_form.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/user/user.dart';
import 'package:qr_code_app/routes/init.dart';
import 'package:qr_code_app/services/repositories/user_repositories.dart';

class EditUserProvider extends GetxController {
  final UserRepositories _userRepositories = UserRepositories();
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> nikController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> subDistrictController = TextEditingController().obs;

  RxList<String> dropdownCategoriesValues = <String>[].obs;
  RxList<int> dropdownCategoriesDeleteValues = <int>[].obs;

  RxList<String> dropdownSubDistrictsValues = <String>[].obs;

  RxList<TextEditingController> listAddressTextController =
      <TextEditingController>[].obs;

  List<TextEditingController> get getListAddressController =>
      listAddressTextController;

  List<String> get getDropdownCategoriesValues => dropdownCategoriesValues;
  List<String> get getDropdownSubDistrictsValues => dropdownSubDistrictsValues;

  RxString dropdownSubDistrictValue = '1'.obs;

  String get getDropdownSubDistrictValue => dropdownSubDistrictValue.value;

  Rx<User> user = User().obs;

  RxBool loading = false.obs;
  RxBool loadingGeneral = false.obs;

  bool get isLoading => loading.value;
  bool get isLoadingGeneral => loadingGeneral.value;

  RxMap<String, String> errorMessages = <String, String>{
    'name': '',
    'nik': '',
    'phoneNumber': '',
  }.obs;

  Map<String, String> get getErrorMessages => errorMessages;

  final List<TextEditingController> textInputControllers = [];

  void addNewCategoryInput({required String newValue}) {
    dropdownCategoriesValues.add(newValue);
    listAddressTextController.add(TextEditingController());
    update();
  }

  void onChangeInputName() {
    if (nameController.value.text == '') {
      errorMessages['name'] = "Input nama harus diisi";
    } else {
      errorMessages['name'] = "";
    }
  }

  void onChangeInputNik() {
    if (nikController.value.text.isNotEmpty &&
        nikController.value.text.length < 16) {
      errorMessages['nik'] = "NIK harus memiliki 16 digit";
    } else {
      errorMessages['nik'] = "";
    }
  }

  Future<void> deleteCategories({
    required int index,
  }) async {
    dropdownCategoriesValues.removeAt(index);
    listAddressTextController.removeAt(index);
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

  void onSubmit({required int pemungutId}) async {
    final int masyarakatId = Get.arguments['id'];

    loadingGeneral.value = true;
    update();

    Categories categories = Categories(insert: [], delete: null);

    for (var i = 0; i < dropdownCategoriesValues.length; i++) {
      categories.insert?.add(
        Meta(
          id: int.parse(dropdownCategoriesValues[i]),
          address: listAddressTextController[i].text,
        ),
      );
    }

    UserCategoriesForm userEditForm = UserCategoriesForm(
      name: nameController.value.text,
      nik: nikController.value.text,
      phoneNumber: phoneNumberController.value.text,
      categories: categories,
      pemungutId: pemungutId,
    );

    try {
      ResponseAPI response = await _userRepositories.changeMasyarakatData(
        userId: masyarakatId,
        user: userEditForm,
      );

      loadingGeneral.value = false;
      update();

      SnackBarCustom.success(message: response.message);

      Get.offAndToNamed(Pages.homePage);
    } on ApiException catch (e) {
      if (e.statusCode == 422) {
        SnackBarCustom.error(message: "Masukkan data yang valid!!");
      } else {
        SnackBarCustom.error(message: e.responseAPI!.message);
      }
      loadingGeneral.value = false;
      update();
    }
  }

  Future<void> getDetailMasyarakat() async {
    try {
      final int masyarakatId = Get.arguments['id'];

      ResponseAPI response = await _userRepositories.getDetailMasyarakat(
        userId: masyarakatId,
      );

      loading.value = false;

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
