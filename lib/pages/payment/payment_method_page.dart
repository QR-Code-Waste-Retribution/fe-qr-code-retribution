import 'package:flutter/material.dart';
import 'package:qr_code_app/pages/qr_code/qr_code_page.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  Size device = const Size(0, 0);
  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Container(
        child: Column(
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
                      'Ayo Bayar Retribusi Sampah Anda :)',
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
                      'Pilih Metode Pembayaran',
                      style: primaryTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const QRCodeGeneratorPage()),
                          ),
                        );
                      },
                      child: Container(
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
                              'Pembayaran Tunai',
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
                              'Pastikan anda sedang bersama Petugas Pemungut Retribusi Sampah',
                              style: primaryTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        color: greenColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pembayaran Non Tunai',
                            style: secondaryTextStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
