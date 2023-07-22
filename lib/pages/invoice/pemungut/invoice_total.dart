import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/atoms/custom_loading.dart';
import 'package:qr_code_app/models/invoice/invoice_model.dart';
import 'package:qr_code_app/models/transaction/transaction_store.dart';
import 'package:qr_code_app/services/providers/auth/auth_provider.dart';
import 'package:qr_code_app/services/providers/transaction/transaction_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:intl/intl.dart';

class InvoiceTotal extends StatefulWidget {
  final InvoiceList invoiceList;
  const InvoiceTotal({Key? key, required this.invoiceList}) : super(key: key);

  @override
  State<InvoiceTotal> createState() => _InvoiceTotalState();
}

class _InvoiceTotalState extends State<InvoiceTotal> {
  double totalPrice = 0;
  TransactionStore transactionStore = TransactionStore();
  final AuthProvider authProvider = Get.find<AuthProvider>();
  final TransactionProvider _transactionProvider =
      Get.find<TransactionProvider>();

  @override
  void initState() {
    super.initState();
    double total = 0;

    List<InvoicesId> invoicesId = [];

    for (var invoice in widget.invoiceList.invoice) {
      total += invoice.price.normalPrice;

      invoicesId
          .add(InvoicesId(parents: invoice.id, variants: invoice.variants));
    }

    transactionStore.invoicesId = invoicesId;
    transactionStore.totalAmount = total;
    transactionStore.masyarakatId = widget.invoiceList.user?.id;
    transactionStore.pemungutId = authProvider.authData.user?.id;
    transactionStore.subDistrictId = authProvider.authData.user?.subDistrictId;
    transactionStore.categoryId = 1;
    transactionStore.type = 'CASH';
    setState(() {
      totalPrice = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> storeTransaction() async {
      _transactionProvider.isLoading.value = true;
      await _transactionProvider
          .storeTransactionInvoiceMasyarakat(transactionStore: transactionStore)
          .then((value) => {_transactionProvider.isLoading.value = false});
    }

    Container invoiceListDetail(Invoice invoice, index) {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tagihan $index',
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Rp. ${invoice.price.formatedPrice}',
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tagihan bulan',
                  style: blackTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                Text(
                  invoice.date,
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
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
        title: Text(
          "Detail Tagihan",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: Obx(
        () {
          if (_transactionProvider.isLoading.value) {
            return const CustomLoading();
          }
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Pastikan uang yang anda terima sesuai dengan jumlah tagihan yang tertera!!!',
                style: blackTextStyle.copyWith(
                  color: Colors.red,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      NumberFormat.currency(
                              locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2)
                          .format(totalPrice),
                      style: blackTextStyle.copyWith(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Detail Tagihan',
                      style: primaryTextStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          itemCount: widget.invoiceList.invoice.length,
                          itemBuilder: (context, index) {
                            return invoiceListDetail(
                                widget.invoiceList.invoice[index], index + 1);
                          }),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    title: 'Lunas',
                    width: 150,
                    margin: const EdgeInsets.only(
                      top: 30,
                      bottom: 80,
                    ),
                    onPressed: () {
                      storeTransaction();
                    },
                  ),
                  CustomButton(
                    title: 'Belum Lunas',
                    width: 150,
                    backgroundColor: Colors.redAccent,
                    margin: const EdgeInsets.only(
                      top: 30,
                      bottom: 80,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
