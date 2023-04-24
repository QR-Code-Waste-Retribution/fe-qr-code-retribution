import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/molekuls/invoice/invoice_card.dart';
import 'package:qr_code_app/models/invoice_model.dart';
import 'package:qr_code_app/services/providers/invoice_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/molekuls/arrow_option_card.dart';

class NonCashPage extends StatefulWidget {
  const NonCashPage({super.key});

  @override
  State<NonCashPage> createState() => _NonCashPageState();
}

class _NonCashPageState extends State<NonCashPage> {
  List<bool>? isChecked;
  bool? isAll = false;
  InvoiceList invoiceListChecked = InvoiceList(invoice: []);
  final InvoiceProvider invoiceProvider = Get.find<InvoiceProvider>();
  bool? tagihan = false;
  Size device = const Size(0, 0);

  void checkAllInvoice(bool value) {
    int i = 0;
    for (var _ in isChecked!) {
      isChecked![i] = value;
      i++;
    }

    if (value) {
      invoiceListChecked = invoiceProvider.getInvoice;
    } else {
      invoiceListChecked = InvoiceList(invoice: []);
    }
  }

  @override
  void initState() {
    super.initState();
    isChecked = List.filled(invoiceProvider.getInvoice.invoice.length, false);
  }

  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    return Scaffold(
      appBar: AppBar(
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
        centerTitle: true,
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Pembayaran Non-Tunai",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(20),
            children: [
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
                    '${invoiceListChecked.invoice.length} / ${invoiceProvider.getInvoice.invoice.length} Terpilih',
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
                  itemCount: invoiceProvider.getInvoice.invoice.length,
                  itemBuilder: (context, index) {
                    final item = invoiceProvider.getInvoice.invoice[index];
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
                                    invoiceListChecked.invoice.add(
                                        invoiceProvider
                                            .getInvoice.invoice[index]);
                                  } else {
                                    invoiceListChecked.invoice.removeWhere(
                                        (element) =>
                                            element ==
                                            invoiceProvider
                                                .getInvoice.invoice[index]);
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
                height: 55,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(15),
              width: device.width,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 5,
                    offset: const Offset(2, -3.5),
                  ),
                ],
              ),
              child: CustomButton(
                title: 'Bayar',
                width: 100,
                height: 40,
                fontSize: 14,
                defaultRadiusButton: 10,
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Color.fromARGB(24, 0, 0, 0),
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        color: whiteColor,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Pilih Metode Pembayaran',
                              style: blackTextStyle.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const ArrowOptionCard(
                                text: 'QRIS',
                                iconsLeading: Icon(
                                  Icons.payments,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/virtual_account_page');
                              },
                              child: const ArrowOptionCard(
                                text: 'Virtual Account',
                                iconsLeading: Icon(
                                  Icons.money_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
