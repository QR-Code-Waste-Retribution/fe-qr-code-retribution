import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/molekuls/snackbar/snackbar.dart';
import 'package:qr_code_app/pages/printer_portable/printer_portable_page.dart';

typedef CallbackPrintFunction = dynamic Function()?;

// SIZE
// 0 : Normal
// 1 : Normal - Bold
// 2 : Medium - Bold
// 3 : Large - Bold

// Align
// 1 : Left
// 2 : Center
// 3 : Right

class PrinterProvider extends GetxController {
  final Rx<BlueThermalPrinter> printer = BlueThermalPrinter.instance.obs;

  final RxList<BluetoothDevice> _devices = <BluetoothDevice>[].obs;

  final Rx<BluetoothDevice>? selectedDevice =
      BluetoothDevice('name', 'address').obs;

  RxInt selectedItemIndex = (-1).obs;

  bool isSelected(int index) => selectedItemIndex.value == index;

  void selectItem(int index) {
    selectedItemIndex.value = index;
    update();
  }

  BlueThermalPrinter get getPrinter => printer.value;

  List<BluetoothDevice> get getListOfBluetoothDevice => _devices;

  BluetoothDevice get getSelectedDevice => selectedDevice!.value;

  RxBool isConnected = false.obs;

  bool get getIsConnected => isConnected.value;

  Future<void> initPlatformState() async {
    _devices.value = await getPrinter.getBondedDevices();
    getPrinter.isConnected.then((value) {
      isConnected.value = value!;
    });
    update();
  }

  void connect() {
    getPrinter.connect(getSelectedDevice).then((value) {
      isConnected.value = value;
      if (value) {
        SnackBarCustom.success(
          message: "Sukses terhubung dengan ${getSelectedDevice.name}!!",
        );
      }
    });
    update();
  }

  void disconnect() {
    getPrinter.disconnect().then((value) {
      if (value) {
        isConnected.value = false;
        SnackBarCustom.success(
          message: "Sukses disconnect dengan ${getSelectedDevice.name}!!",
        );
        selectedItemIndex.value = -1;
        selectedDevice?.value = BluetoothDevice('name', 'address');
      }
    });
    update();
  }

  Future<void> showModalAllPrinters({
    required BuildContext context,
    required double height,
    required CallbackPrintFunction callback,
  }) async {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      elevation: 1,
      useSafeArea: true,
      backgroundColor: const Color.fromARGB(24, 0, 0, 0),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.85,
          child: PrinterPortablePage(
            onPrint: callback,
          ),
        );
      },
    );
  }

  bool checkIsAnySelected() {
    return selectedItemIndex.value != -1;
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

  Future<void>? print(CallbackPrintFunction callbackPrintFunction) async {
    if ((await getPrinter.isConnected)!) {
      callbackPrintFunction!();
      Get.back();
      SnackBarCustom.success(message: "Berhasil print bukti pembayaran !!");
    }
  }

  @override
  void onInit() {
    super.onInit();
    initPlatformState();
  }
}
