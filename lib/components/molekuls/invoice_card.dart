import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(value: false, onChanged: (newVal) {}),
              Text(
                "Tagihan 1",
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tagihan bulan :',
                      style: blackTextStyle,
                    ),
                    Text(
                      'Desember 2022 - Desember 2022',
                      style: primaryTextStyle,
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
                      'Kategori :',
                      style: blackTextStyle,
                    ),
                    Text(
                      'Toko/Kios',
                      style: primaryTextStyle,
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
                      'Kecamatan :',
                      style: blackTextStyle,
                    ),
                    Text(
                      'Kec. Habinsaran',
                      style: primaryTextStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alamat :',
                      style: blackTextStyle,
                    ),
                    Text(
                      'Toko Trisno, Pasar I Parsoburan, Kecamatan Habinsaran, Kabupaten Toba',
                      style: primaryTextStyle,
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
                      'Bayar Tunai :',
                      style: blackTextStyle,
                    ),
                    Text(
                      'Rp 30.000, 00 -',
                      style: primaryTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: blackColor,
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
