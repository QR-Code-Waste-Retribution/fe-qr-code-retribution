import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  Size device = const Size(0, 0);

  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: secondaryColor,
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
          "Rincinan Pembayaran",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        width: device.width,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: device.width * 0.85,
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 40, bottom: 10),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Rp. 100,000.00 -',
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Berhasil',
                          style: blackTextStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Table(
                          textDirection: TextDirection.ltr,
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            // Kategori
                            TableRow(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: blackColor,
                                  ),
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    'Kategori',
                                    style: blackTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    'Arena Hiburan/Panggung Hiburan Rakyat',
                                    style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Metode Pembayaran
                            TableRow(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: blackColor,
                                  ),
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: Text(
                                    'Metode Pembayaran',
                                    style: blackTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: Text(
                                    'Tunai',
                                    style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // No Referensi
                            TableRow(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: blackColor,
                                  ),
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: Text(
                                    'No Referensi',
                                    style: blackTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: Text(
                                    '36382528344',
                                    style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Waktu Selesai
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: Text(
                                    'Waktu',
                                    style: blackTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: Text(
                                    '22-12-22 13:55',
                                    style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomButton(
                        onPressed: () {
                          Get.toNamed('printer_portable_page');
                        },
                        title: 'Print',
                        width: 120,
                        height: 40,
                        defaultRadiusButton: 7,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      CustomButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
                          );
                        },
                        backgroundColor: redColor,
                        title: 'Kembali',
                        width: 120,
                        height: 40,
                        defaultRadiusButton: 7,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: thirdColor,
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  color: whiteColor,
                  size: 60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
