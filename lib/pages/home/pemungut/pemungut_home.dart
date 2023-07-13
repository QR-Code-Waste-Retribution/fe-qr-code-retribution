import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/pemungut_transaction_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/atoms/custom_loading.dart';
import 'package:qr_code_app/utils/number_format_price.dart';

class PemungutHome extends StatefulWidget {
  final Size device;
  const PemungutHome({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  State<PemungutHome> createState() => _PemungutHomeState();
}

class _PemungutHomeState extends State<PemungutHome> {
  final PemungutTransactionProvider _pemungutTransactionProvider =
      Get.find<PemungutTransactionProvider>();

  final AuthProvider _authProvider = Get.find<AuthProvider>();

  @override
  void initState() {
    super.initState();
    _pemungutTransactionProvider.isLoading.value = true;
    _pemungutTransactionProvider.getAllPemungutTransactionByPemungutId(
        pemungutId: _authProvider.authData.user?.id);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_pemungutTransactionProvider.isLoading.value) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          child: CustomLoading(
            textColor: secondaryColor,
            loadingColor: secondaryColor,
          ),
        );
      }
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Catatan Keuangan',
                      style: primaryTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed('/history_payment_pemungut'),
                      child: Text(
                        'Lihat Detail',
                        style: linkTextStyle.copyWith(),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: 5,
                        offset: const Offset(2, 3.5),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: whiteColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 15,
                        ),
                        child: const Icon(
                          Icons.arrow_circle_down,
                          color: primaryColor,
                          size: 50,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total iuran yang sudah anda\nkumpulkan di bulan ini',
                            style: secondaryTextStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            NumberFormatPrice().formatPrice(
                              price:
                                  _pemungutTransactionProvider.getTotalIncome,
                            ),
                            style: blackTextStyle.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status',
                style: primaryTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 5,
                          offset: const Offset(2, 3.5),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor,
                    ),
                    width: widget.device.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tagihan iuran retribusi sampah bulan ini :',
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Belum Disetor',
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          NumberFormatPrice().formatPrice(
                              price: _pemungutTransactionProvider
                                  .getNotYetDeposited()),
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Sudah Disetor :',
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          NumberFormatPrice().formatPrice(
                              price: _pemungutTransactionProvider
                                  .getAlreadyDeposited()),
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    });
  }
}
