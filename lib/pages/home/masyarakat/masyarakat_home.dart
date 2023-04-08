import 'package:flutter/material.dart';
import 'package:qr_code_app/components/atoms/custom_header.dart';
import 'package:qr_code_app/components/molekuls/invoice_card.dart';
import 'package:qr_code_app/core/constants/app_invoice.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class MasyarakatHome extends StatefulWidget {
  const MasyarakatHome({
    Key? key,
    required this.device,
  }) : super(key: key);

  final Size device;
  @override
  State<MasyarakatHome> createState() => _MasyarakatHomeState();
}

class _MasyarakatHomeState extends State<MasyarakatHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'Ayooo, Jangan lupa membayar kewajiban retribusi anda untuk Toba yang lebih indah dan bersih',
          style: blackTextStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),

        // Informasi Iuran
        CustomHeader(text: 'Informasi Iuran'),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12.5),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Tagihan anda',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' belum lunas',
                      style: alertTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jumlah tagihan',
                    style: blackTextStyle,
                  ),
                  Text(
                    'Rp. 45,000.00 -',
                    style: blackTextStyle.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Lakukan Pembayaran >',
                    textAlign: TextAlign.end,
                    style: priceTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),

        // Detail Iuran
        CustomHeader(text: 'Detail Iuran'),
        SizedBox(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              final item = AppInvoice.invoiceList[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Tagihan ' + (index + 1).toString(),
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  InvoiceCard(
                    invoice: item,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
