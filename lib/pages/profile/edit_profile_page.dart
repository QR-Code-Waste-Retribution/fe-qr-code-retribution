import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/users_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/atoms/custom_header.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/molekuls/input/input_group.dart';
import 'package:qr_code_app/utils/alert_dialog_custom.dart';
import 'package:qr_code_app/models/form/edit_profile_form.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  var phoneNumberController = TextEditingController();
  var addressController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
  }

  Future<void> saveChangeEditedProfile() async {

    _authProvider.editProfile(
      userId: _authProvider.getUserId!,
      editProfileForm: EditProfileForm(
        phoneNumber: phoneNumberController.text,
        address: addressController.text,
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
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
          "Profil",
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
          const CustomHeader(
            text: 'Edit Data Diri',
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Icon(Icons.person),
              const SizedBox(
                width: 20,
              ),
              Text(
                _authProvider.userName!,
                style: primaryTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(Icons.settings_phone),
              const SizedBox(
                width: 20,
              ),
              Text(
                _authProvider.userPhoneNumber!,
                style: primaryTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          InputGroup(
            hintText: "No Telepon",
            subLabel: 'Cth : 082167663638',
            inputController: phoneNumberController,
            keyboardType: TextInputType.number,
          ),
          InputGroup(
            hintText: "Alamat",
            subLabel:
                'Cth : Toko Trisno, Pasar I Parsoburan Kecamatan Habinsaran, Kabupaten Toba',
            inputController: addressController,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            title: 'Simpan',
            width: 120,
            height: 45,
            fontSize: 14,
            defaultRadiusButton: 10,
            onPressed: () {
              AlertDialogCustom.showAlertDialog(
                context: context,
                onYes: () => saveChangeEditedProfile(),
                title: "Edit profil",
                content: 'Apakah anda yakin?',
              );
            },
          ),
        ],
      ),
    );
  }
}
