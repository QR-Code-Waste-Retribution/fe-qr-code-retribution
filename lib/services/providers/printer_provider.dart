import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:get/get.dart';

typedef CallbackPrintFunction = void Function();

class PrinterProvider extends GetxController {
  final Rx<BlueThermalPrinter> printer = BlueThermalPrinter.instance.obs;

  final RxList<BluetoothDevice> _devices = <BluetoothDevice>[].obs;

  final Rx<BluetoothDevice>? selectedDevice = BluetoothDevice('name', 'address').obs;

  BlueThermalPrinter get getPrinter => printer.value;

  Future<void> initPlatformState() async {
    _devices.value = await getPrinter.getBondedDevices();
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
      // TODO: Make function print GETX Dynamically
      callbackPrintFunction();
    }
  }


  @override
  void onInit() {
    super.onInit();
    initPlatformState();
  }

}