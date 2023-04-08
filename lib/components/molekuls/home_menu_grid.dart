import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/data/home_menu.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class HomeMenuGrid extends StatelessWidget {
  final AuthProvider authProvider = Get.find<AuthProvider>();

  HomeMenuGrid({
    Key? key,
    required this.device,
  }) : super(key: key);

  final Size device;

  @override
  Widget build(BuildContext context) {

    String? role = authProvider.userRole;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      width: device.width * 0.9,
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 5,
            offset: const Offset(2, 3.5),
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: EdgeInsets.only(
          top: 0,
        ),
        itemCount: listHomeMenu[role]?.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Container(
              width: device.width,
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(200),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 5,
                          offset: const Offset(2, 3.5),
                        ),
                      ],
                    ),
                    child: Icon(
                      listHomeMenu[role]![index].iconImage,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    children: [
                      Text(
                        listHomeMenu[role]![index].iconText,
                        textAlign: TextAlign.center,
                        style: primaryTextStyle.copyWith(
                          fontSize: 12.5,
                          color: blackColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
