import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/molekuls/option_tile/option_tile.dart';
import 'package:qr_code_app/models/transaction/transaction_invoice.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/printer_provider.dart';
import 'package:qr_code_app/services/providers/transaction_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/utils/logger.dart';
import 'package:qr_code_app/utils/number_format_price.dart';

class PrinterPortablePage extends StatefulWidget {
  const PrinterPortablePage({super.key});

  @override
  State<PrinterPortablePage> createState() => _PrinterPortablePageState();
}

class _PrinterPortablePageState extends State<PrinterPortablePage> {
  final TransactionProvider _transactionProvider =
      Get.find<TransactionProvider>();

  final AuthProvider _authProvider = Get.find<AuthProvider>();

  final PrinterProvider printerProvider = Get.find<PrinterProvider>();

  @override
  void initState() {
    super.initState();
  }

  Size device = const Size(0, 0);

  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    TransactionInvoice transactionInvoice =
        _transactionProvider.getTransactionInvoice;

    List<String> splitStringByLength(String input, int length) {
      List<String> result = [];
      int startIndex = 0;
      int endIndex = length;

      while (startIndex < input.length) {
        if (endIndex > input.length) {
          endIndex = input.length;
        }
        result.add(input.substring(startIndex, endIndex));
        startIndex = endIndex;
        endIndex += length;
      }

      return result;
    }

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
          List<String> parts =
              splitStringByLength(invoice.category?.name ?? '', 15);
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
      // SIZE
      // 0 : Normal
      // 1 : Normal - Bold
      // 2 : Medium - Bold
      // 3 : Large - Bold

      // Align
      // 1 : Left
      // 2 : Center
      // 3 : Right
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
        automaticallyImplyLeading: false,
        title: Text(
          "Pilih Printer Portable",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            printerProvider.getIsConnected
                ? Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.green.shade400,
                    ),
                    child: Text(
                      "Printer sudah terhubung !!!",
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  )
                : const SizedBox(),
            Obx(() {
              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: printerProvider.getListOfBluetoothDevice.length,
                    itemBuilder: (context, position) {
                      return OptionTile(
                        onTap: () {
                          printerProvider.selectedItemIndex.value = position;
                          printerProvider.selectedDevice!.value =
                              printerProvider
                                  .getListOfBluetoothDevice[position];
                        },
                        selected:
                            printerProvider.selectedItemIndex.value == position,
                        label: printerProvider
                            .getListOfBluetoothDevice[position].name!,
                        subLabel: printerProvider
                            .getListOfBluetoothDevice[position].address!,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      printerProvider.getIsConnected
                          ? CustomButton(
                              title:
                                  'Disconnect ${printerProvider.getSelectedDevice.name}',
                              width: device.width * 0.8,
                              height: 40,
                              fontSize: 15,
                              backgroundColor: redColor,
                              defaultRadiusButton: 5,
                              onPressed: () {
                                printerProvider.getPrinter.disconnect();
                              },
                            )
                          : CustomButton(
                              title: printerProvider.checkIsAnySelected()
                                  ? 'Hubungkan ${printerProvider.getSelectedDevice.name}'
                                  : "Silahkan pilih printer terlebih dahulu",
                              width: device.width * 0.8,
                              height: 40,
                              backgroundColor:
                                  printerProvider.checkIsAnySelected()
                                      ? primaryColor
                                      : secondaryTextColor,
                              fontSize: 15,
                              defaultRadiusButton: 5,
                              onPressed: printerProvider.checkIsAnySelected() ? () async {
                                printerProvider.connect(); 
                              } : null,
                            ),
                    ],
                  ),
                  printerProvider.getIsConnected
                      ? CustomButton(
                          title: printerProvider.selectedItemIndex.value != -1
                              ? 'Hubungkan ${printerProvider.getSelectedDevice.name}'
                              : "Silahkan pilih printer terlebih dahulu",
                          width: device.width * 0.8,
                          height: 40,
                          fontSize: 15,
                          defaultRadiusButton: 5,
                          onPressed: () async {
                            if ((await printerProvider
                                .getPrinter.isConnected)!) {
                              printInvoice();
                            }
                          },
                        )
                      : const SizedBox(),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
