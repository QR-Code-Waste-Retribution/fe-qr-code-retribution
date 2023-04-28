import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/data/home_menu.dart';
import 'package:qr_code_app/models/user.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class HomeMenuGrid extends StatelessWidget {
  const HomeMenuGrid({
    Key? key,
    required this.device,
    required this.authProvider,
  }) : super(key: key);

  final Size device;
  final AuthData authProvider;

  @override
  Widget build(BuildContext context) {
    String? role = authProvider.user?.role.name;

    return Container(
      padding: const EdgeInsets.symmetric(
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
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: const EdgeInsets.only(
          top: 0,
        ),
        itemCount: listHomeMenu[role]?.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(listHomeMenu[role]![index].href);
            },
            child: Center(
              child: SizedBox(
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
                    const SizedBox(
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
            ),
          );
        },
      ),
    );
  }
}
