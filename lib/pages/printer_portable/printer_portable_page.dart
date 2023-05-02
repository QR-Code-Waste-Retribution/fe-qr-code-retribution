import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/transaction/transaction_invoice.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/transaction_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:qr_code_app/utils/number_format_price.dart';

class PrinterPortablePage extends StatefulWidget {
  const PrinterPortablePage({super.key});

  @override
  State<PrinterPortablePage> createState() => _PrinterPortablePageState();
}

class _PrinterPortablePageState extends State<PrinterPortablePage> {
  BlueThermalPrinter printer = BlueThermalPrinter.instance;
  final TransactionProvider _transactionProvider =
      Get.find<TransactionProvider>();

  final AuthProvider _authProvider = Get.find<AuthProvider>();

  List<BluetoothDevice> _devices = [];
  BluetoothDevice? selected_device;
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _devices = await printer.getBondedDevices();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
      for (var invoice in transactionInvoice.invoice!) {
        List<String> parts =
            splitStringByLength(invoice.category?.name ?? '', 15);
        int index = 0;
        for (var item in parts) {
          if (index == 0) {
            printer.printLeftRight(
                item,
                '[${invoice.variantsCount}] | ${NumberFormatPrice()
                .formatPrice(
                  price: invoice.price?.normalPrice,
                  decimalDigits: 0,
                )}',
                0);
          } else {
            printer.printLeftRight(item, '', 0);
          }
          index++;
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
      printer.printNewLine();
      printer.printCustom("Tagihan Retribusi Sampah", 0, 2);
      printer.printNewLine();
      printer.printLeftRight(
          "Pemungut", '${_authProvider.authData.user?.name}', 1);
      printer.printLeftRight("Kategori", '', 1);
      categoryInvoiceName();
      printer.printLeftRight("Metode", "Tunai", 1);
      printer.printLeftRight("Pembayaran", "", 1);
      printer.printLeftRight("No Referensi",
          "${transactionInvoice.transaction?.referenceNumber}", 1);
      printer.printLeftRight("Jumlah Tagihan",
          "Rp. ${transactionInvoice.transaction?.price?.formatedPrice}", 1);
      printer.printLeftRight("Waktu",
          "${transactionInvoice.transaction?.createdAt?.formatedDate}", 1);
      printer.printNewLine();
      printer.printNewLine();
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, position) => ListTile(
                  onTap: () {
                    setState(() {
                      selected_device = _devices[position];
                    });
                  },
                  selectedColor: Colors.amber,
                  style: ListTileStyle.drawer,
                  leading: const Icon(Icons.print),
                  title: Text(_devices[position].name!),
                  subtitle: Text(_devices[position].address!),
                ),
                itemCount: _devices.length,
              ),
              ElevatedButton(
                onPressed: () {
                  printer.connect(selected_device!);
                },
                child: Text('Connect'),
              ),
              ElevatedButton(
                onPressed: () {
                  printer.disconnect();
                },
                child: Text('Disconnect'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if ((await printer.isConnected)!) {
                    printInvoice();
                  }
                },
                child: Text('Print'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
