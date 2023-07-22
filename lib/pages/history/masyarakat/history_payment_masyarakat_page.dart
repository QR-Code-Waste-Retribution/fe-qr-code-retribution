import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/services/providers/auth/auth_provider.dart';
import 'package:qr_code_app/services/providers/transaction/transaction_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/utils/date_format.dart';

class HistoryPaymentMasyarakatPage extends StatefulWidget {
  const HistoryPaymentMasyarakatPage({super.key});

  @override
  State<HistoryPaymentMasyarakatPage> createState() =>
      _HistoryPaymentMasyarakatPageState();
}

class _HistoryPaymentMasyarakatPageState
    extends State<HistoryPaymentMasyarakatPage> {
  final TransactionProvider _transactionProvider =
      Get.find<TransactionProvider>();

  final AuthProvider _authProvider = Get.find<AuthProvider>();

  Size device = const Size(0, 0);

  @override
  void initState() {
    super.initState();
    _transactionProvider.getTransactionByMasyarakatId(
        masyarakatId: _authProvider.authData.user?.id);
  }

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
                    'Lihat Riwayat Pembayaran Anda',
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
                    'Riwayat Pembayaran',
                    style: primaryTextStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Data di urutkan berdasarkan tanggal yang terbaru',
                    style: primaryTextStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: secondaryTextColor,
                    ),
                  ),
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _transactionProvider
                          .getTransactionList.transaction?.length,
                      itemBuilder: (context, index) {
                        final item = _transactionProvider
                            .getTransactionList.transaction?[index];
                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: shadowColor,
                                blurRadius: 10,
                                blurStyle: BlurStyle.outer,
                                offset: const Offset(2, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    FormatDate().format(item?.date),
                                    style: primaryTextStyle.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: secondaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${item?.type}',
                                      style: primaryTextStyle.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: whiteColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Rp. ${item?.price?.formatedPrice}',
                                style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${item?.createdAt?.formatedDate}',
                                style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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
