import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class PrinterPortable extends StatefulWidget {
  const PrinterPortable({super.key});

  @override
  State<PrinterPortable> createState() => _PrinterPortableState();
}

class _PrinterPortableState extends State<PrinterPortable> {
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: secondaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            "Profile",
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
                DropdownButton(
                  value: selected_device,
                  items: _devices
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name!),
                        ),
                      )
                      .toList(),
                  onChanged: (device) {
                    setState(() {
                      selected_device = device;
                    });
                  },
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
      ),
    );
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
    printer.printCustom("Tagihan Retribusi Sampah", 0, 1);
    printer.printLeftRight("Kategori", '', 1);
    printer.printLeftRight("Arena Hiburan/Panggung Hiburan Rakyat", '', 1);
    printer.printLeftRight("Metode", "Tunai", 1);
    printer.printLeftRight("Pembayaran", "", 1);
    printer.printLeftRight("No Referensi", "36382528344", 1);
    printer.printLeftRight("Jumlah Tagihan", "Rp. 100.000", 1);
    printer.printLeftRight("Waktu", "22-12-22 13:55", 1);
  }
}
