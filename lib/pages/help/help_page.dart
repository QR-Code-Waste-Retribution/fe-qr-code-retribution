import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> listItems = [
  Item(
      expandedValue:
          'Dengan Aplikasi Retribusi Sampah masyarakat bisa membayar tarif retribusi sampah dengan mudah baik secara tunai maupun non-tunai. ',
      headerValue: 'Apa Kegunaan Aplikasi Retribusi Sampah?'),
  Item(
      expandedValue:
          'Dengan Aplikasi Retribusi Sampah masyarakat bisa membayar tarif retribusi sampah dengan mudah baik secara tunai maupun non-tunai. ',
      headerValue: 'Apa saja Fitur di dalam Aplikasi Retribusi Sampah?'),
  Item(
      expandedValue:
          'Dengan Aplikasi Retribusi Sampah masyarakat bisa membayar tarif retribusi sampah dengan mudah baik secara tunai maupun non-tunai. ',
      headerValue:
          'Bagaimana cara melakukan pembayaran tarif retribusi sampah?'),
  Item(
      expandedValue:
          'Dengan Aplikasi Retribusi Sampah masyarakat bisa membayar tarif retribusi sampah dengan mudah baik secara tunai maupun non-tunai. ',
      headerValue: 'Bagaimana cara melakukan pembayaran tunai?'),
  Item(
      expandedValue:
          'Dengan Aplikasi Retribusi Sampah masyarakat bisa membayar tarif retribusi sampah dengan mudah baik secara tunai maupun non-tunai. ',
      headerValue: 'Bagaimana cara melakukan pembayaran non-tunai?'),
];

class _HelpPageState extends State<HelpPage> {
  final List<Item> _data = listItems;

  Size device = const Size(0, 0);
  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Cari Kebutuhan Informasimu pada fitur Bantuan',
                      style: whiteTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Image.asset(
                    'assets/image/payment_method_img.png',
                    width: device.width * 0.35,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Text(
                      'Pertanyaan Umum',
                      style: primaryTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ExpansionPanelList(
                      animationDuration: const Duration(milliseconds: 700),
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _data[index].isExpanded = !isExpanded;
                        });
                      },
                      children: _data.map<ExpansionPanel>((Item item) {
                        return ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(
                                item.headerValue,
                                style: blackTextStyle,
                              ),
                            );
                          },
                          body: ListTile(
                            title: Text(
                              item.expandedValue,
                              style: blackTextStyle,
                            ),
                          ),
                          isExpanded: item.isExpanded,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
