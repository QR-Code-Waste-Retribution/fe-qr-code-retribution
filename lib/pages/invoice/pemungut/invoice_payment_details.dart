import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/models/transaction/transaction_invoice.dart';
import 'package:qr_code_app/routes/init.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/printer_provider.dart';
import 'package:qr_code_app/services/providers/transaction_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/utils/number_format_price.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  Size device = const Size(0, 0);
  final TransactionProvider _transactionProvider =
      Get.find<TransactionProvider>();

  final AuthProvider _authProvider = Get.find<AuthProvider>();
  final PrinterProvider printerProvider = Get.find<PrinterProvider>();

  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );

    TransactionInvoice transactionInvoice =
        _transactionProvider.getTransactionInvoice;

    void categoryInvoiceName() {
      if (transactionInvoice.invoice!.isEmpty) {
        printerProvider.getPrinter.printLeftRight(
            '${transactionInvoice.transaction?.category?.name}',
            '[1] | ${NumberFormatPrice().formatPrice(
              price: transactionInvoice.transaction?.price?.normalPrice,
              decimalDigits: 0,
            )}',
            0);
      } else {
        for (var invoice in transactionInvoice.invoice!) {
          List<String> parts = printerProvider.splitStringByLength(
              invoice.category?.name ?? '', 15);
          int index = 0;
          for (var item in parts) {
            if (index == 0) {
              printerProvider.getPrinter.printLeftRight(
                  item,
                  '[${invoice.variantsCount ?? 1}] | ${NumberFormatPrice().formatPrice(
                    price: invoice.price?.normalPrice,
                    decimalDigits: 0,
                  )}',
                  0);
            } else {
              printerProvider.getPrinter.printLeftRight(item, '', 0);
            }
            index++;
          }
        }
      }
    }

    void printInvoice() {
      printerProvider.getPrinter.printNewLine();
      printerProvider.getPrinter.printCustom("Tagihan Retribusi Sampah", 0, 2);
      printerProvider.getPrinter.printNewLine();
      printerProvider.getPrinter.printLeftRight(
          "Pemungut", '${_authProvider.authData.user?.name}', 1);
      printerProvider.getPrinter.printLeftRight("Kategori", '', 1);
      categoryInvoiceName();
      printerProvider.getPrinter.printLeftRight("Metode", "Tunai", 1);
      printerProvider.getPrinter.printLeftRight("Pembayaran", "", 1);
      printerProvider.getPrinter.printLeftRight("No Referensi",
          "${transactionInvoice.transaction?.referenceNumber}", 1);
      printerProvider.getPrinter.printLeftRight("Jumlah Tagihan",
          "Rp. ${transactionInvoice.transaction?.price?.formatedPrice}", 1);
      printerProvider.getPrinter.printLeftRight("Waktu",
          "${transactionInvoice.transaction?.createdAt?.formatedDate}", 1);
      printerProvider.getPrinter.printNewLine();
      printerProvider.getPrinter.printNewLine();
    }

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
              Get.back();
          }),
        ),
        title: Text(
          "Rincinan Pembayaran",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        width: device.width,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: device.width * 0.85,
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 40, bottom: 10),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Rp. ${transactionInvoice.transaction?.price?.formatedPrice} -',
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Berhasil',
                          style: blackTextStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Table(
                          textDirection: TextDirection.ltr,
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            // Kategori
                            TableRow(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: blackColor,
                                  ),
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    'Kategori',
                                    style: blackTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    '${transactionInvoice.invoice != null && transactionInvoice.invoice!.isNotEmpty ? transactionInvoice.invoice![0].category?.name : transactionInvoice.transaction?.category?.name}',
                                    style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Metode Pembayaran
                            TableRow(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: blackColor,
                                  ),
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: Text(
                                    'Metode Pembayaran',
                                    style: blackTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: Text(
                                    '${transactionInvoice.transaction?.type}',
                                    style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // No Referensi
                            TableRow(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: blackColor,
                                  ),
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: Text(
                                    'No Referensi',
                                    style: blackTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: Text(
                                    '${transactionInvoice.transaction?.referenceNumber}',
                                    style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Waktu Selesai
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: Text(
                                    'Waktu',
                                    style: blackTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: Text(
                                    '${transactionInvoice.transaction?.createdAt?.formatedDate}',
                                    style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomButton(
                        onPressed: () {
                          printerProvider.showModalAllPrinters(
                              context: context,
                              height: device.height,
                              callback: () {
                                printInvoice();
                              });
                        },
                        title: 'Print',
                        width: 120,
                        height: 40,
                        defaultRadiusButton: 7,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      CustomButton(
                        onPressed: () {
                          Get.offAndToNamed(Pages.homePage);
                        },
                        backgroundColor: redColor,
                        title: 'Kembali',
                        width: 120,
                        height: 40,
                        defaultRadiusButton: 7,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: thirdColor,
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  color: whiteColor,
                  size: 60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
