import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/atoms/custom_header.dart';
import 'package:qr_code_app/components/molekuls/search_input.dart';

class RecapitulationPage extends StatefulWidget {
  const RecapitulationPage({super.key});

  @override
  State<RecapitulationPage> createState() => _RecapitulationPageState();
}

class _RecapitulationPageState extends State<RecapitulationPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  Size device = const Size(0, 0);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

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
        automaticallyImplyLeading: false,
        bottom: TabBar(
          dividerColor: whiteColor,
          indicatorColor: Colors.amber[700],
          indicatorWeight: 3,
          controller: tabController,
          tabs: const [
            Tab(
              text: "LUNAS",
            ),
            Tab(
              text: "BELUM LUNAS",
            ),
          ],
        ),
        title: Text(
          "Riwayat Tagihan",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ContainerTabsRecapitulation(device: device),
          ContainerTabsRecapitulation(device: device),
        ],
      ),
    );
  }
}

class ContainerTabsRecapitulation extends StatelessWidget {
  const ContainerTabsRecapitulation({
    super.key,
    required this.device,
  });

  final Size device;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: device.width,
      height: 100,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 5,
                  offset: const Offset(2, 3.5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Text(
                        'Total tagihan yang\nsudah lunas',
                        style: blackTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '158',
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Text(
                        'Total yang harus\ndipungut',
                        style: blackTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '158',
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const CustomHeader(
            text: 'Berikut daftar tagihan Kec. Ajibata',
          ),
          const SizedBox(
            height: 15,
          ),
          const SearchInputWidget(),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 15,
            itemBuilder: (context, index) {
              // final item = widget.invoiceList.invoice[index];
              return Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 5,
                      offset: const Offset(2, 3.5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ahmad Sianipar',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '08213672382',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
