import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/categories/category.dart';
import 'package:qr_code_app/models/form/user_form.dart';
import 'package:qr_code_app/models/geographic/sub_district.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/categories_provider.dart';
import 'package:qr_code_app/services/providers/geographic_provider.dart';
import 'package:qr_code_app/services/providers/users_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/molekuls/input/input_group.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  var nameController = TextEditingController();
  var usernameController = TextEditingController();
  var nikController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var categoryController = TextEditingController();
  var subDistrictController = TextEditingController();
  var addressController = TextEditingController();

  final CategoriesProvider _categoriesProvider = Get.find<CategoriesProvider>();
  final AuthProvider _authProvider = Get.find<AuthProvider>();
  final UsersProvider _usersProvider = Get.find<UsersProvider>();
  final GeographicProvider _geographicProvider = Get.find<GeographicProvider>();

  String dropdownCategoryValue = '1';
  String dropdownSubDistrictValue = '';

  List<TextEditingController> textInputControllers = [];

  @override
  void dispose() {
    super.dispose();
    for (var controller in textInputControllers) {
      controller.dispose();
    }
  }

  @override
  void initState() {
    super.initState();
    // Add the text input controllers to the list
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
      dropdownCategoryValue =
          _categoriesProvider.getCategoriesList.categories[0].id.toString();
      _categoriesProvider.priceSelectedCategories(
        idSelected: _categoriesProvider.getCategoriesList.categories[0].id!,
      );
    });
    _geographicProvider
        .getAllSubDistrictByDistrictId(districtId: _authProvider.districtId!)
        .then((value) {
      dropdownSubDistrictValue =
          _geographicProvider.getListSubDistricts![0].id.toString();
      dropdownSubDistrictValue =
          _authProvider.userSubDistrictId!;
    });
  }

  void addUserAction() {
    UserForm userForm = UserForm(
      name: nameController.text,
      nik: nikController.text,
      username: usernameController.text,
      gender: "Laki-Laki",
      phoneNumber: phoneNumberController.text,
      category: int.parse(dropdownCategoryValue),
      address: addressController.text,
      districtId: _authProvider.districtId!,
      subDistrictId: int.parse(dropdownSubDistrictValue),
      pemungutId: _authProvider.getUserId!,
    );

    _usersProvider
        .storeRegisterUser(userForm: userForm)
        .then((value) => clearInput());
  }

  void clearInput() {
    for (var controller in textInputControllers) {
      controller.clear();
    }
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
      body: ListView(
        padding: const EdgeInsets.all(20),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                    decoration: BoxDecoration(
                      color: backgroundColor6,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      alignment: Alignment.bottomCenter,
                      value: dropdownCategoryValue,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 24,
                      borderRadius: BorderRadius.circular(20),
                      underline: Container(height: 0),
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownCategoryValue = newValue!;
                        });
                        _categoriesProvider.priceSelectedCategories(
                          idSelected: int.parse(newValue!),
                        );
                      },
                      items: _categoriesProvider.getCategoriesList.categories
                          .map<DropdownMenuItem<String>>((Category category) {
                        return DropdownMenuItem(
                          enabled: category.name == dropdownCategoryValue
                              ? false
                              : true,
                          value: category.id.toString(),
                          child: Text(
                            "${category.name}",
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
          ),
          const SizedBox(
            height: 12,
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
                      value: dropdownSubDistrictValue,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 24,
                      borderRadius: BorderRadius.circular(20),
                      underline: Container(height: 0),
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownSubDistrictValue = newValue!;
                        });
                      },
                      items: _geographicProvider.getListSubDistricts
                          ?.map<DropdownMenuItem<String>>(
                              (SubDistrict subDistrict) {
                        return DropdownMenuItem(
                          enabled: subDistrict.name == dropdownSubDistrictValue
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
          ),
          const SizedBox(
            height: 10,
          ),
          InputGroup(
            hintText: "Alamat",
            required: true,
            inputController: addressController,
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
                onPressed: () => clearInput(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
