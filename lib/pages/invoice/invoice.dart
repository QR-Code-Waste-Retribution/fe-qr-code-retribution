import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/molekuls/invoice_card.dart';
import 'package:qr_code_app/models/invoice_model.dart';
import 'package:qr_code_app/pages/invoice/invoice_total.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class InvoicePage extends StatefulWidget {
  final InvoiceList invoiceList;
  const InvoicePage({Key? key, required this.invoiceList}) : super(key: key);

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  List<bool>? isChecked;
  bool? isAll = false;
  InvoiceList invoiceListChecked = InvoiceList(invoice: []);
  bool? tagihan = false;
  Size device = const Size(0, 0);

  @override
  void initState() {
    super.initState();
    isChecked = List.filled(widget.invoiceList.invoice.length, false);
  }

  void checkAllInvoice(bool value) {
    int i = 0;
    for (var item in isChecked!) {
      isChecked![i] = value;
      i++;
    }

    if (value) {
      invoiceListChecked = widget.invoiceList;
    } else {
      invoiceListChecked = InvoiceList(invoice: []);
    }
  }

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
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Ahmad Sianipar',
            textAlign: TextAlign.center,
            style: primaryTextStyle.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isAll,
                    onChanged: (bool? value) {
                      setState(() {
                        isAll = value!;
                        checkAllInvoice(value);
                      });
                    },
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
                ],
              ),
              Text(
                '${invoiceListChecked.invoice.length} / ${widget.invoiceList.invoice.length} Terpilih',
                style: primaryTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: alertColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.invoiceList.invoice.length,
              itemBuilder: (context, index) {
                final item = widget.invoiceList.invoice[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked?[index],
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked?[index] = value!;
                              if (value!) {
                                invoiceListChecked.invoice
                                    .add(widget.invoiceList.invoice[index]);
                              } else {
                                invoiceListChecked.invoice.removeWhere((element) =>
                                    element == widget.invoiceList.invoice[index]);
                              }
                            });
                          },
                        ),
                        Text(
                          'Tagihan ${index + 1}',
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    InvoiceCard(
                      invoice: item,
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(
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
              Get.to(
                () => InvoiceTotal(
                  invoiceList: invoiceListChecked,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
