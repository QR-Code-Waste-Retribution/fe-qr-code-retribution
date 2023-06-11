import 'package:flutter/material.dart';
import 'package:qr_code_app/core/constants/app_constants.dart';
import 'package:qr_code_app/models/payment_method_page.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  final AuthProvider authProvider = Get.find<AuthProvider>();

  late RolePayment _rolePayment;

  @override
  void initState() {
    super.initState();

    if (authProvider.authData.user?.role?.name == 'pemungut') {
      _rolePayment = AppConstants.preferencesPaymentMethodPage.pemungut;
    } else {
      _rolePayment = AppConstants.preferencesPaymentMethodPage.masyarakat;
    }
  }

  Size device = const Size(0, 0);
  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );

    return Scaffold(
      backgroundColor: secondaryColor,
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _rolePayment.header,
                    style: whiteTextStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Image.asset(
                  'assets/image/payment_method_img.png',
                  width: device.width * 0.35,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    _rolePayment.titleBody,
                    style: primaryTextStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    itemCount: _rolePayment.option.length,
                    itemBuilder: (context, index) {
                      final item = _rolePayment.option[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(item.targetUrl);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: greenColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: secondaryTextStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: secondaryColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                item.body,
                                style: primaryTextStyle,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
