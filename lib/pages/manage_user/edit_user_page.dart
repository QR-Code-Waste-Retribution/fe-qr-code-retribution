import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/atoms/custom_loading.dart';
import 'package:qr_code_app/components/molekuls/input/input_group_custom.dart';
import 'package:qr_code_app/components/molekuls/snackbar/snackbar.dart';
import 'package:qr_code_app/models/categories/category.dart';
import 'package:qr_code_app/models/geographic/sub_district.dart';
import 'package:qr_code_app/services/providers/auth/auth_provider.dart';
import 'package:qr_code_app/services/providers/categories/categories_provider.dart';
import 'package:qr_code_app/services/providers/geographic_provider.dart';
import 'package:qr_code_app/services/providers/manage_user/edit_user_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/atoms/button/button_group.dart';
import 'package:qr_code_app/components/molekuls/input/input_group.dart';
import 'package:qr_code_app/utils/alert_dialog_custom.dart';

class EditUserPage extends StatelessWidget {
  EditUserPage({super.key});

  final CategoriesProvider _categoriesProvider = Get.find<CategoriesProvider>();
  final AuthProvider _authProvider = Get.find<AuthProvider>();
  final GeographicProvider _geographicProvider = Get.find<GeographicProvider>();
  final EditUserProvider _editUserProvider = Get.find<EditUserProvider>();

  void addUserAction() {
    _editUserProvider.onSubmit(
      pemungutId: _authProvider.getUserId!,
    );
  }

  @override
  Widget build(BuildContext context) {
    _categoriesProvider.isLoading.value = true;
    _categoriesProvider
        .getAllCategories(districtId: _authProvider.districtId!)
        .then((value) {
      _categoriesProvider.priceSelectedCategories(
        idSelected: _categoriesProvider.getCategoriesList.categories[0].id!,
      );
    });
    _editUserProvider.loading.value = true;
    _geographicProvider
        .getAllSubDistrictByDistrictId(districtId: _authProvider.districtId!)
        .then((value) {
      _editUserProvider.dropdownSubDistrictValue.value =
          _geographicProvider.getListSubDistricts![0].id.toString();
      _editUserProvider.dropdownSubDistrictValue.value =
          _authProvider.userSubDistrictId!;
      _editUserProvider.getDetailMasyarakat();
    });

    Future<bool> onWillPop() async {
      _editUserProvider.back();
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
              _editUserProvider.back();
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
        body: Obx(
          () => _editUserProvider.isLoadingGeneral
              ? CustomLoading(
                  textColor: secondaryColor,
                  loadingColor: secondaryColor,
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        InputGroupCustom(
                          errorText: _editUserProvider.getErrorMessages['name'],
                          onChanged: (value) {
                            _editUserProvider.onChangeInputName();
                          },
                          hintText: "Nama",
                          required: true,
                          inputController:
                              _editUserProvider.nameController.value,
                        ),
                        InputGroupCustom(
                          errorText: _editUserProvider.getErrorMessages['nik'],
                          onChanged: (value) {
                            _editUserProvider.onChangeInputNik();
                          },
                          hintText: "NIK",
                          maxLength: 16,
                          inputController:
                              _editUserProvider.nikController.value,
                          keyboardType: TextInputType.number,
                        ),
                        InputGroup(
                          hintText: "No. Telepon",
                          required: true,
                          keyboardType: TextInputType.number,
                          inputController:
                              _editUserProvider.phoneNumberController.value,
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
                                  _editUserProvider.addNewCategoryInput(
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
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _editUserProvider
                                  .dropdownCategoriesValues.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomGroupButton(
                                      title: 'Hapus Kategori',
                                      width: 150,
                                      height: 25,
                                      fontSize: 10,
                                      defaultRadiusButton: 10,
                                      backgroundColor: redColor,
                                      onPressed: () {
                                        if (_editUserProvider
                                                .getDropdownCategoriesValues
                                                .length ==
                                            1) {
                                          SnackBarCustom.error(
                                            message:
                                                "Kategori wajib retribusi harus memiliki satu kategori",
                                          );
                                        } else {
                                          AlertDialogCustom.showAlertDialog(
                                            context: context,
                                            onYes: () {
                                              return _editUserProvider
                                                  .deleteCategories(
                                                index: index,
                                              );
                                            },
                                            title: "Hapus kategori",
                                            content: 'Apakah anda yakin?',
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Pilih Kategori',
                                                style:
                                                    primaryTextStyle.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Obx(
                                                () => _editUserProvider
                                                        .isLoading
                                                    ? CustomLoading(
                                                        loadingColor:
                                                            secondaryColor,
                                                      )
                                                    : Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 15,
                                                                vertical: 1),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              backgroundColor6,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: DropdownButton<
                                                            String>(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          value: _editUserProvider
                                                                  .getDropdownCategoriesValues[
                                                              index],
                                                          isExpanded: true,
                                                          icon: const Icon(Icons
                                                              .arrow_drop_down_rounded),
                                                          iconSize: 24,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          underline: Container(
                                                              height: 0),
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .deepPurple),
                                                          onChanged: (String?
                                                              newValue) {
                                                            _editUserProvider
                                                                    .getDropdownCategoriesValues[
                                                                index] = newValue!;
                                                          },
                                                          items: _categoriesProvider
                                                              .getCategoriesList
                                                              .categories
                                                              .map<
                                                                  DropdownMenuItem<
                                                                      String>>((Category
                                                                  category) {
                                                            return DropdownMenuItem(
                                                              enabled: category
                                                                          .name ==
                                                                      _editUserProvider
                                                                              .getDropdownCategoriesValues[
                                                                          index]
                                                                  ? false
                                                                  : true,
                                                              value: category.id
                                                                  .toString(),
                                                              child: Text(
                                                                "${category.name}",
                                                                style:
                                                                    blackTextStyle
                                                                        .copyWith(
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
                                        InputGroup(
                                          hintText: "Alamat",
                                          required: true,
                                          inputController: _editUserProvider
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
                              onPressed: () {
                                _editUserProvider.clearInput();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
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
                value: _editUserProvider.dropdownSubDistrictValue.value,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                iconSize: 24,
                borderRadius: BorderRadius.circular(20),
                underline: Container(height: 0),
                style: const TextStyle(color: Colors.deepPurple),
                onChanged: (String? newValue) {
                  _editUserProvider.dropdownSubDistrictValue.value = newValue!;
                },
                items: _geographicProvider.getListSubDistricts
                    ?.map<DropdownMenuItem<String>>((SubDistrict subDistrict) {
                  return DropdownMenuItem(
                    enabled: subDistrict.name ==
                            _editUserProvider.dropdownSubDistrictValue.value
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
    );
  }
}
