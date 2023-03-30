import 'package:flutter/material.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/molekuls/invoice_card.dart';
import 'package:qr_code_app/pages/invoice/invoice_total.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  bool? tagihan = false;
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
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: (() {
            setState(() {
              Navigator.pop(context);
            });
          }),
        ),
        title: Text(
          "Detail Tagihan",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            'Ahmad Sianipar',
            textAlign: TextAlign.center,
            style: primaryTextStyle.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            'Pilih Semua',
            textAlign: TextAlign.right,
            style: primaryTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: priceColor,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          InvoiceCard(),
          InvoiceCard(),
          InvoiceCard(),
          InvoiceCard(),
          SizedBox(
            height: 15,
          ),
          Text(
            'Apakah masyarakat ingin membayar retribusi sampah secara tunai sekarang?',
            style: primaryTextStyle.copyWith(),
          ),
          CustomButton(
            title: 'Bayar',
            width: 220,
            margin: const EdgeInsets.only(
              top: 30,
              bottom: 80,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => InvoiceTotal()),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
