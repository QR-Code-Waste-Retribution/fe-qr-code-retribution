import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/user/user.dart';
import 'package:qr_code_app/services/providers/pagination_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class HomeMenuGrid extends StatelessWidget {
  HomeMenuGrid({
    Key? key,
    required this.device,
    required this.authProvider,
  }) : super(key: key);

  final Size device;
  final AuthData authProvider;
  final PaginationProvider _paginationProvider = Get.find<PaginationProvider>();

  @override
  Widget build(BuildContext context) {
    String? role = authProvider.user?.role?.name;

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
        itemCount: _paginationProvider.listHomeMenu[role]?.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: _paginationProvider.listHomeMenu[role]![index].onClick,
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
                        _paginationProvider.listHomeMenu[role]![index].iconImage,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      children: [
                        Text(
                          _paginationProvider.listHomeMenu[role]![index].iconText,
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
