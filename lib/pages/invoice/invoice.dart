import 'package:flutter/material.dart';
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
  InvoiceList invoiceListChecked = InvoiceList(data: []);
  bool? tagihan = false;
  Size device = const Size(0, 0);

  @override
  void initState() {
    super.initState();
    isChecked = List.filled(widget.invoiceList.data.length, false);
  }

  void checkAllInvoice(bool value) {
    int i = 0;
    for (var item in isChecked!) {
      isChecked![i] = value;
      i++;
    }

    if (value) {
      invoiceListChecked = this.widget.invoiceList;
    } else {
      invoiceListChecked = InvoiceList(data: []);
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
                invoiceListChecked.data.length.toString() +
                    ' / ' +
                    this.widget.invoiceList.data.length.toString() +
                    ' Terpilih',
                style: primaryTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: alertColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.invoiceList.data.length,
              itemBuilder: (context, index) {
                final item = widget.invoiceList.data[index];
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
                                invoiceListChecked.data
                                    .add(widget.invoiceList.data[index]);
                              } else {
                                invoiceListChecked.data.removeWhere((element) =>
                                    element == widget.invoiceList.data[index]);
                              }
                            });
                          },
                        ),
                        Text(
                          'Tagihan ' + (index + 1).toString(),
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
                  builder: ((context) => InvoiceTotal(
                        invoiceList: invoiceListChecked,
                      )),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
