import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_loading.dart';
import 'package:qr_code_app/models/invoice/invoice_paid_unpaid.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/invoice_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/atoms/custom_header.dart';
import 'package:qr_code_app/components/molekuls/input/search_input.dart';

class RecapitulationPage extends StatefulWidget {
  const RecapitulationPage({super.key});

  @override
  State<RecapitulationPage> createState() => _RecapitulationPageState();
}

class _RecapitulationPageState extends State<RecapitulationPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  Size device = const Size(0, 0);

  final InvoiceProvider _invoiceProvider = Get.find<InvoiceProvider>();
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _invoiceProvider.getAllUserForInvoicePaidAndUnpaid(
        subDistrictId: _authProvider.subDistrictId);
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
      body: Obx(
        () => _invoiceProvider.getIsLoading
            ? CustomLoading()
            : TabBarView(
                controller: tabController,
                children: [
                  ContainerTabsRecapitulation(
                    device: device,
                    usersPaidUnPaid:
                        _invoiceProvider.getInvoicePaidUnPaid.usersPaid!,
                  ),
                  ContainerTabsRecapitulation(
                    device: device,
                    usersPaidUnPaid:
                        _invoiceProvider.getInvoicePaidUnPaid.usersUnpaid!,
                    type: "Belum Lunas",
                  ),
                ],
              ),
      ),
    );
  }
}

class ContainerTabsRecapitulation extends StatelessWidget {
  const ContainerTabsRecapitulation({
    super.key,
    required this.device,
    this.type = "sudah lunas",
    required this.usersPaidUnPaid,
  });

  final Size device;
  final String type;
  final UsersPaidUnPaid usersPaidUnPaid;

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
                        'Total tagihan yang\n$type',
                        style: blackTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        usersPaidUnPaid.count.toString(),
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
                        usersPaidUnPaid.count.toString(),
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
            itemCount: usersPaidUnPaid.records?.length,
            itemBuilder: (context, index) {
              final item = usersPaidUnPaid.records?[index];
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
                      '${item?.name}',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${item?.phoneNumber}',
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
