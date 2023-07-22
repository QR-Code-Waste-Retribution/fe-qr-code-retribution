import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/molekuls/option_tile/option_tile.dart';
import 'package:qr_code_app/services/providers/printer/printer_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class PrinterPortablePage extends StatefulWidget {
  final dynamic Function()? onPrint;

  const PrinterPortablePage({super.key, required this.onPrint});

  @override
  State<PrinterPortablePage> createState() => _PrinterPortablePageState();
}

class _PrinterPortablePageState extends State<PrinterPortablePage> {

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
            const SizedBox(
              height: 15,
            ),
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
                                printerProvider.disconnect();
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
                              onPressed: printerProvider.checkIsAnySelected()
                                  ? () async {
                                      printerProvider.connect();
                                    }
                                  : null,
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  printerProvider.getIsConnected
                      ? CustomButton(
                          title: "Print bukti pembayaran",
                          width: device.width * 0.8,
                          height: 40,
                          fontSize: 15,
                          defaultRadiusButton: 5,
                          onPressed: () async {
                            printerProvider.print(widget.onPrint);
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
