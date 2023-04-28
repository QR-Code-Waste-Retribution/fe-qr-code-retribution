import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class HistoryPaymentPemungutPage extends StatefulWidget {
  const HistoryPaymentPemungutPage({super.key});

  @override
  State<HistoryPaymentPemungutPage> createState() =>
      _HistoryPaymentPemungutPageState();
}

class _HistoryPaymentPemungutPageState
    extends State<HistoryPaymentPemungutPage> {
  Size device = const Size(0, 0);
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
            setState(() {
              Get.back();
            });
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
      body: Column(
        children: [
          const SizedBox(
            height: 20,
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
                          'Rp. 10.640.000 -,',
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
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      // final item = widget.invoiceList.invoice[index];
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Desember 2022',
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
                                    'Tunai',
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
                              'Rp. 20.000',
                              style: blackTextStyle.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '12/11/2022',
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
        ],
      ),
    );
  }
}
