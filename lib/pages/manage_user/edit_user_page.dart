import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/atoms/custom_loading.dart';
import 'package:qr_code_app/models/categories/category.dart';
import 'package:qr_code_app/models/geographic/sub_district.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/categories_provider.dart';
import 'package:qr_code_app/services/providers/geographic_provider.dart';
import 'package:qr_code_app/services/providers/users_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/atoms/button/button_group.dart';
import 'package:qr_code_app/components/molekuls/input/input_group.dart';

class EditUserPage extends StatelessWidget {
  EditUserPage({super.key});

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final nikController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final categoryController = TextEditingController();
  final subDistrictController = TextEditingController();
  final addressController = TextEditingController();

  final CategoriesProvider _categoriesProvider = Get.find<CategoriesProvider>();
  final AuthProvider _authProvider = Get.find<AuthProvider>();
  final UsersProvider _usersProvider = Get.find<UsersProvider>();
  final GeographicProvider _geographicProvider = Get.find<GeographicProvider>();

  final List<TextEditingController> textInputControllers = [];

  void addUserAction() {}

  void clearInput() {
    for (var controller in textInputControllers) {
      controller.clear();
    }
    _usersProvider.clearInput();
  }

  @override
  Widget build(BuildContext context) {
    textInputControllers.addAll([
      nameController,
      usernameController,
      nikController,
      phoneNumberController,
      categoryController,
      subDistrictController,
      addressController,
    ]);
    _categoriesProvider.isLoading.value = true;
    _categoriesProvider
        .getAllCategories(districtId: _authProvider.districtId!)
        .then((value) {
      _categoriesProvider.priceSelectedCategories(
        idSelected: _categoriesProvider.getCategoriesList.categories[0].id!,
      );
      _usersProvider.dropdownCategoriesValues.add(
          _categoriesProvider.getCategoriesList.categories[0].id.toString());
    });
    _geographicProvider
        .getAllSubDistrictByDistrictId(districtId: _authProvider.districtId!)
        .then((value) {
      _usersProvider.dropdownSubDistrictValue.value =
          _geographicProvider.getListSubDistricts![0].id.toString();
      _usersProvider.dropdownSubDistrictValue.value =
          _authProvider.userSubDistrictId!;
    });

    Future<bool> onWillPop() async {
      _usersProvider.back();
      return true;
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: secondaryColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
            onPressed: (() {
              _usersProvider.back();
            }),
          ),
          title: Text(
            "Edit Akun Masyarakat",
            style: primaryTextStyle.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              color: whiteColor,
              fontSize: 16,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                InputGroup(
                  hintText: "Nama",
                  required: true,
                  inputController: nameController,
                ),
                InputGroup(
                  hintText: "Username/Email",
                  required: true,
                  inputController: usernameController,
                ),
                InputGroup(
                  hintText: "NIK",
                  inputController: nikController,
                  keyboardType: TextInputType.number,
                ),
                InputGroup(
                  hintText: "No. Telepon",
                  required: true,
                  keyboardType: TextInputType.number,
                  inputController: phoneNumberController,
                ),
                const SizedBox(
                  height: 7,
                ),
                subDistrictDropdown(),
                const SizedBox(
                  height: 20,
                ),
                Obx(() {
                  if (_categoriesProvider.getIsLoading) {
                    return CustomLoading(
                      textColor: secondaryColor,
                      loadingColor: secondaryColor,
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomGroupButton(
                        title: 'Tambah Kategori',
                        width: 150,
                        height: 25,
                        fontSize: 10,
                        defaultRadiusButton: 10,
                        backgroundColor: orangeLight,
                        onPressed: () {
                          _usersProvider.addNewCategoryInput(
                            newValue: _categoriesProvider
                                .getCategoriesList.categories[0].id
                                .toString(),
                          );
                        },
                      ),
                    ],
                  );
                }),
                const SizedBox(
                  height: 5,
                ),
                Obx(() {
                  return SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _usersProvider.dropdownCategoriesValues.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            const Divider(),
                            Column(
                              children: [
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pilih Kategori',
                                        style: primaryTextStyle.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Obx(
                                        () => Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 1),
                                          decoration: BoxDecoration(
                                            color: backgroundColor6,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: DropdownButton<String>(
                                            alignment: Alignment.bottomCenter,
                                            value: _usersProvider
                                                    .getDropdownCategoriesValues[
                                                index],
                                            isExpanded: true,
                                            icon: const Icon(
                                                Icons.arrow_drop_down_rounded),
                                            iconSize: 24,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            underline: Container(height: 0),
                                            style: const TextStyle(
                                                color: Colors.deepPurple),
                                            onChanged: (String? newValue) {
                                              _usersProvider
                                                      .getDropdownCategoriesValues[
                                                  index] = newValue!;
                                            },
                                            items: _categoriesProvider
                                                .getCategoriesList.categories
                                                .map<DropdownMenuItem<String>>(
                                                    (Category category) {
                                              return DropdownMenuItem(
                                                enabled: category.name ==
                                                        _usersProvider
                                                                .getDropdownCategoriesValues[
                                                            index]
                                                    ? false
                                                    : true,
                                                value: category.id.toString(),
                                                child: Text(
                                                  "${category.name}",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputGroup(
                                  hintText: "Alamat",
                                  required: true,
                                  inputController: _usersProvider
                                      .getListAddressController[index],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      title: 'Simpan',
                      width: 120,
                      height: 45,
                      fontSize: 14,
                      defaultRadiusButton: 10,
                      onPressed: () => addUserAction(),
                    ),
                    CustomButton(
                      title: 'Batal',
                      width: 120,
                      height: 45,
                      fontSize: 14,
                      backgroundColor: redColor,
                      defaultRadiusButton: 10,
                      onPressed: () => clearInput(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox subDistrictDropdown() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pilih Kecamatan',
            style: primaryTextStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 1,
              ),
              decoration: BoxDecoration(
                color: backgroundColor6,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                alignment: Alignment.bottomCenter,
                value: _usersProvider.dropdownSubDistrictValue.value,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                iconSize: 24,
                borderRadius: BorderRadius.circular(20),
                underline: Container(height: 0),
                style: const TextStyle(color: Colors.deepPurple),
                onChanged: (String? newValue) {
                  _usersProvider.dropdownSubDistrictValue.value = newValue!;
                },
                items: _geographicProvider.getListSubDistricts
                    ?.map<DropdownMenuItem<String>>((SubDistrict subDistrict) {
                  return DropdownMenuItem(
                    enabled: subDistrict.name ==
                            _usersProvider.dropdownSubDistrictValue.value
                        ? false
                        : true,
                    value: subDistrict.id.toString(),
                    child: Text(
                      subDistrict.name,
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
