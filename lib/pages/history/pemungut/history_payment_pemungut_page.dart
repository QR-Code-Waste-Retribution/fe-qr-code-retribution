import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_loading.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/transaction_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/utils/number_format_price.dart';

class HistoryPaymentPemungutPage extends StatefulWidget {
  const HistoryPaymentPemungutPage({super.key});

  @override
  State<HistoryPaymentPemungutPage> createState() =>
      _HistoryPaymentPemungutPageState();
}

class _HistoryPaymentPemungutPageState
    extends State<HistoryPaymentPemungutPage> {
  final TransactionProvider _transactionProvider =
      Get.find<TransactionProvider>();
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  Size device = const Size(0, 0);

  @override
  void initState() {
    // _transactionProvider.isLoading.value = true;
    _transactionProvider.getAllTransactionByPemungutId(
        pemungutId: _authProvider.authData.user?.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
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
          "Riwayat Pembayaran",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      backgroundColor: secondaryColor,
      body: SizedBox(
        width: device.width,
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Obx(
                  () => ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: greenThin,
                          boxShadow: [
                            BoxShadow(
                              color: shadowColor,
                              blurRadius: 5,
                              offset: const Offset(2, 3.5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Tagihan di bulan ini :',
                              style: blackTextStyle,
                            ),
                            Text(
                              NumberFormatPrice().formatPrice(
                                  price: _transactionProvider
                                      .getTransactionList.totalAmount),
                              style: blackTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: secondaryTextColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
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
                                      'Rp. ${item?.price?.formatedPrice}',
                                      style: blackTextStyle.copyWith(
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
                                  '${item?.updatedAt?.formatedDate}',
                                  style: blackTextStyle.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
