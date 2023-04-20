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
