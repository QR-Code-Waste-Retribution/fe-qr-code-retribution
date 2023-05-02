import 'package:flutter/material.dart';
import 'package:qr_code_app/models/invoice/invoice_model.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class InvoiceCard extends StatelessWidget {
  final Invoice invoice;
  const InvoiceCard({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tagihan bulan :',
                style: blackTextStyle,
              ),
              Text(
                invoice.date,
                style: primaryTextStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kategori :',
                style: blackTextStyle,
              ),
              Text(
                invoice.category.name,
                style: primaryTextStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kecamatan :',
                style: blackTextStyle,
              ),
              Text(
                'Kec. ${invoice.subDistrictName}',
                style: primaryTextStyle,
              ),
            ],
          ),
          const SizedBox(
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
                invoice.address,
                style: primaryTextStyle,
              ),
            ],
          ),
          const SizedBox(
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
                'Rp ${invoice.price.formatedPrice} -',
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
    );
  }
}
