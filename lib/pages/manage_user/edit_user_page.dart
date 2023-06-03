import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/molekuls/input/input_group.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  var nameController = TextEditingController();
  var usernameController = TextEditingController();
  var nikController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var categoryController = TextEditingController();
  var subDistrictController = TextEditingController();
  var addressController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    usernameController.dispose();
    nikController.dispose();
    phoneNumberController.dispose();
    categoryController.dispose();
    subDistrictController.dispose();
    addressController.dispose();
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
            setState(() {
              Get.back();
            });
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
          ),
          InputGroup(
            hintText: "No. Telepon",
            required: true,
            inputController: phoneNumberController,
          ),
          InputGroup(
            hintText: "Kategori",
            required: true,
            inputController: categoryController,
          ),
          InputGroup(
            hintText: "Kecamatan",
            required: true,
            inputController: subDistrictController,
          ),
          InputGroup(
            hintText: "Alamat",
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
                onPressed: () {},
              ),
              CustomButton(
                title: 'Batal',
                width: 120,
                height: 45,
                fontSize: 14,
                backgroundColor: redColor,
                defaultRadiusButton: 10,
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
