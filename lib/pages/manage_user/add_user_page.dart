import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/molekuls/input/input_group_custom.dart';
import 'package:qr_code_app/models/categories/category.dart';
import 'package:qr_code_app/models/geographic/sub_district.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/categories_provider.dart';
import 'package:qr_code_app/services/providers/geographic_provider.dart';
import 'package:qr_code_app/services/providers/manage_user/add_user_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final AddUserProvider addUserProvider = Get.find<AddUserProvider>();
  final CategoriesProvider _categoriesProvider = Get.find<CategoriesProvider>();
  final AuthProvider _authProvider = Get.find<AuthProvider>();
  final GeographicProvider _geographicProvider = Get.find<GeographicProvider>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _categoriesProvider.isLoading.value = true;
    _categoriesProvider
        .getAllCategories(districtId: _authProvider.districtId!)
        .then((value) {
      addUserProvider.dropdownCategoryValue.value =
          _categoriesProvider.getCategoriesList.categories[0].id.toString();
      _categoriesProvider.priceSelectedCategories(
        idSelected: _categoriesProvider.getCategoriesList.categories[0].id!,
      );
    });
    _geographicProvider
        .getAllSubDistrictByDistrictId(districtId: _authProvider.districtId!)
        .then((value) {
      addUserProvider.dropdownSubDistrictValue.value =
          _geographicProvider.getListSubDistricts![0].id.toString();
      addUserProvider.dropdownSubDistrictValue.value =
          _authProvider.userSubDistrictId!;
    });
  }

  void addUserAction() {
    addUserProvider.submit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: secondaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: (() {
            Get.back();
          }),
        ),
        title: Text(
          "Tambah Akun Masyarakat",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            InputGroupCustom(
              errorText: addUserProvider.getErrorMessages['name'],
              onChanged: (value) {
                addUserProvider.onChangeInputName();
              },
              hintText: "Nama",
              required: true,
              inputController: addUserProvider.nameController.value,
            ),
            InputGroupCustom(
              errorText: addUserProvider.getErrorMessages['username'],
              onChanged: (value) {
                addUserProvider.onChangeInputUsername();
              },
              hintText: "Username",
              required: true,
              inputController: addUserProvider.usernameController.value,
            ),
            InputGroupCustom(
              errorText: addUserProvider.getErrorMessages['nik'],
              onChanged: (value) {
                addUserProvider.onChangeInputNik();
              },
              hintText: "NIK",
              inputController: addUserProvider.nikController.value,
              keyboardType: TextInputType.number,
            ),
            InputGroupCustom(
              errorText: addUserProvider.getErrorMessages['phoneNumber'],
              onChanged: (value) {
                addUserProvider.onChangePhoneNumber();
              },
              hintText: "No. Telepon",
              required: true,
              keyboardType: TextInputType.number,
              inputController: addUserProvider.phoneNumberController.value,
            ),
            InputGroupCustom(
              errorText: addUserProvider.getErrorMessages['email'],
              onChanged: (value) {
                addUserProvider.onChangeInputEmail();
              },
              hintText: "Email",
              required: true,
              inputController: addUserProvider.emailController.value,
            ),
            const SizedBox(
              height: 7,
            ),
            SizedBox(
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
                        value: addUserProvider.getDropdownSubDistrictValue,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        iconSize: 24,
                        borderRadius: BorderRadius.circular(20),
                        underline: Container(height: 0),
                        style: const TextStyle(color: Colors.deepPurple),
                        onChanged: (String? newValue) {
                          setState(() {
                            addUserProvider.dropdownSubDistrictValue.value =
                                newValue!;
                          });
                        },
                        items: _geographicProvider.getListSubDistricts
                            ?.map<DropdownMenuItem<String>>(
                                (SubDistrict subDistrict) {
                          return DropdownMenuItem(
                            enabled: subDistrict.name ==
                                    addUserProvider.getDropdownSubDistrictValue
                                ? false
                                : true,
                            value: subDistrict.id.toString(),
                            child: Text(
                              subDistrict.name,
                              style: blackTextStyle.copyWith(
                                fontSize: 14,
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
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        alignment: Alignment.bottomCenter,
                        value: addUserProvider.getDropdownCategoryValue,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        iconSize: 24,
                        borderRadius: BorderRadius.circular(20),
                        underline: Container(height: 0),
                        style: const TextStyle(color: Colors.deepPurple),
                        onChanged: (String? newValue) {
                          addUserProvider.dropdownCategoryValue.value =
                              newValue!;
                          _categoriesProvider.priceSelectedCategories(
                            idSelected: int.parse(newValue),
                          );
                        },
                        items: _categoriesProvider.getCategoriesList.categories
                            .map<DropdownMenuItem<String>>((Category category) {
                          return DropdownMenuItem(
                            enabled: category.name ==
                                    addUserProvider.getDropdownCategoryValue
                                ? false
                                : true,
                            value: category.id.toString(),
                            child: Text(
                              "${category.name}",
                              style: blackTextStyle.copyWith(
                                fontSize: 14,
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
              height: 12,
            ),
            InputGroupCustom(
              errorText: addUserProvider.getErrorMessages['phoneNumber'],
              onChanged: (value) {
                addUserProvider.onChangeInputAddress();
              },
              hintText: "Alamat",
              required: true,
              inputController: addUserProvider.addressController.value,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  title: 'Tambah',
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
                  onPressed: () => addUserProvider.clearInput(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
