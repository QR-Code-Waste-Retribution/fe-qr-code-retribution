import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/core/constants/app_constants.dart';
import 'package:qr_code_app/models/virtual_account.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/molekuls/arrow_option_card.dart';

class VirtualAccountPage extends StatefulWidget {
  const VirtualAccountPage({super.key});

  @override
  State<VirtualAccountPage> createState() => _VirtualAccountPageState();
}

class _VirtualAccountPageState extends State<VirtualAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          centerTitle: true,
          backgroundColor: secondaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            "Pilih Virtual Account",
            style: primaryTextStyle.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              color: whiteColor,
              fontSize: 16,
            ),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: AppConstants.virtualAccountList.length,
          itemBuilder: (context, index) {
            VirtualAccount item = AppConstants.virtualAccountList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: GestureDetector(
                onTap: () {},
                child: ArrowOptionCard(
                  text: item.name,
                  iconsLeading: item.icon,
                ),
              ),
            );
          },
        ));
  }
}
