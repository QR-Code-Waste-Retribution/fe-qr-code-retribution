import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/molekuls/input/input_group.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
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
          const InputGroup(
            hintText: "Nama *",
          ),
          const InputGroup(
            hintText: "Username/Email *",
          ),
          const InputGroup(
            hintText: "NIK *",
          ),
          const InputGroup(
            hintText: "No. Telepon *",
          ),
          const InputGroup(
            hintText: "Kategori *",
          ),
          const InputGroup(
            hintText: "Kecamatan *",
          ),
          const InputGroup(
            hintText: "Alamat *",
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
