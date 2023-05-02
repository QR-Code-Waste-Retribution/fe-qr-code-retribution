import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class InvoiceTotalPaidStatus extends StatefulWidget {
  const InvoiceTotalPaidStatus({super.key, required this.masyarakatName});
  final String? masyarakatName;

  @override
  State<InvoiceTotalPaidStatus> createState() => _InvoiceTotalPaidStatusState();
}

class _InvoiceTotalPaidStatusState extends State<InvoiceTotalPaidStatus> {
  Size device = const Size(0, 0);
  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 12.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 5,
                  offset: const Offset(2, 3.5),
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(vertical: 7),
            padding: const EdgeInsets.all(15),
            width: device.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Tagihan ${widget.masyarakatName} ',
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ' sudah lunas',
                        style: alertTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.blueAccent),
                      ),
                      TextSpan(
                        text: ' hingga bulan ini',
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Image.asset('assets/image/invoice_success_paid_off.png'),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        'Kembali >',
                        textAlign: TextAlign.right,
                        style: priceTextStyle.copyWith(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
