import 'package:flutter/material.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/pages/invoice/payment_details.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class InvoiceTotal extends StatefulWidget {
  const InvoiceTotal({super.key});

  @override
  State<InvoiceTotal> createState() => _InvoiceTotalState();
}

class _InvoiceTotalState extends State<InvoiceTotal> {
  @override
  Widget build(BuildContext context) {
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
            'Pastikan uang yang anda terima sesuai dengan jumlah tagihan yang tertera!!!',
            style: blackTextStyle.copyWith(
              color: Colors.red,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  'Rp 45.000',
                  style: blackTextStyle.copyWith(
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Detail Tagihan',
                  style: primaryTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tagihan 1',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Rp. 30.000',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tagihan bulan',
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Desember 2022 - Januari 2023',
                      style: primaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tagihan 2',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Rp. 15.000',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tagihan bulan',
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Desember 2022 - Januari 2023',
                      style: primaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                title: 'Lunas',
                width: 150,
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 80,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => PaymentDetails()),
                    ),
                  );
                },
              ),
              CustomButton(
                title: 'Belum Lunas',
                width: 150,
                backgroundColor: Colors.redAccent,
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 80,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
