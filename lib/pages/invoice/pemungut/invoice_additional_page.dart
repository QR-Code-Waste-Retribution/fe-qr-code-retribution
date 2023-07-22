import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/atoms/custom_loading.dart';
import 'package:qr_code_app/models/categories/category.dart';
import 'package:qr_code_app/models/transaction/transaction_store.dart';
import 'package:qr_code_app/services/providers/auth/auth_provider.dart';
import 'package:qr_code_app/services/providers/categories/categories_provider.dart';
import 'package:qr_code_app/services/providers/transaction/transaction_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_app/utils/number_format_price.dart';

class InvoiceAdditionalPage extends StatefulWidget {
  const InvoiceAdditionalPage({Key? key}) : super(key: key);

  @override
  State<InvoiceAdditionalPage> createState() => _InvoiceAdditionalPageState();
}

class _InvoiceAdditionalPageState extends State<InvoiceAdditionalPage> {
  double totalPrice = 0;

  final TransactionProvider _transactionProvider =
      Get.find<TransactionProvider>();

  final CategoriesProvider _categoriesProvider = Get.find<CategoriesProvider>();
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  TransactionStore transactionStore = TransactionStore();

  @override
  void initState() {
    super.initState();

    transactionStore.invoicesId = [
      InvoicesId(
        parents: _categoriesProvider.getCategorySelected?.id,
        variants: [],
      )
    ];
    transactionStore.totalAmount =
        _categoriesProvider.getCategorySelected?.price?.toDouble();
    transactionStore.masyarakatId = 1;
    transactionStore.pemungutId = _authProvider.getUserId;
    transactionStore.subDistrictId = _authProvider.subDistrictId;
    transactionStore.categoryId = _categoriesProvider.getCategorySelected?.id;
    transactionStore.type = 'CASH';
  }

  @override
  Widget build(BuildContext context) {
    Future<void> storeTransaction() async {
      _transactionProvider.isLoading.value = true;
      await _transactionProvider.storeTransactionAdditionalMasyarakat(
          transactionStore: transactionStore);
    }

    Container invoiceListDetail(Category category, index) {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kategori',
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "${category.name}",
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
                  'Bayar Tunai',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Text(
                  NumberFormatPrice().formatPrice(price: category.price),
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
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
                          .format(
                              _categoriesProvider.getCategorySelected?.price),
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
                    invoiceListDetail(
                      _categoriesProvider.getCategorySelected!,
                      1,
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
