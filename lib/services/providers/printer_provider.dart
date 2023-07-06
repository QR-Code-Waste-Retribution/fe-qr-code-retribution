import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/pages/printer_portable/printer_portable_page.dart';

typedef CallbackPrintFunction = void Function();

class PrinterProvider extends GetxController {
  final Rx<BlueThermalPrinter> printer = BlueThermalPrinter.instance.obs;

  final RxList<BluetoothDevice> _devices = <BluetoothDevice>[].obs;

  final Rx<BluetoothDevice>? selectedDevice =
      BluetoothDevice('name', 'address').obs;

  BlueThermalPrinter get getPrinter => printer.value;

  List<BluetoothDevice> get getListOfBluetoothDevice => _devices;


  Future<void> initPlatformState() async {
    _devices.value = await getPrinter.getBondedDevices();
  }

  Future<void> showModalAllPrinters({
    required BuildContext context,
    required double height,
  }) async {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color.fromARGB(24, 0, 0, 0),
      builder: (BuildContext context) {
        return const PrinterPortablePage();
      },
    );
  }

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

  Future<void> print(CallbackPrintFunction callbackPrintFunction) async {
    if ((await getPrinter.isConnected)!) {
      callbackPrintFunction();
    }
  }

  @override
  void onInit() {
    super.onInit();
    initPlatformState();
  }
}
