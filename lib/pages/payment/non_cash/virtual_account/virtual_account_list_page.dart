
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_loading.dart';
import 'package:qr_code_app/core/constants/app_constants.dart';
import 'package:qr_code_app/models/doku/virtual_account/virtual_account.dart';
import 'package:qr_code_app/models/transaction/transaction_noncash.dart';
import 'package:qr_code_app/services/providers/transaction_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/molekuls/arrow_option_card.dart';
import 'package:qr_code_app/utils/alert_dialog_custom.dart';

class VirtualAccountListPage extends StatefulWidget {
  const VirtualAccountListPage({super.key});

  @override
  State<VirtualAccountListPage> createState() => _VirtualAccountListPageState();
}

class _VirtualAccountListPageState extends State<VirtualAccountListPage> {
  final TransactionProvider _transactionProvider =
      Get.find<TransactionProvider>();

  final TransactionNonCash _transactionNonCash =
      TransactionNonCash.fromJson(Get.arguments);

  Future<void> transaction({required String typeVA, required String bankFullName}) async {
    _transactionProvider.isLoading.value = true;
    _transactionProvider
        .storeTransactionInvoiceMasyarakatVirtualAccount(
          transactionNonCash: _transactionNonCash,
          typeVA: typeVA,
        )
        .then((value) => {_transactionProvider.isLoading.value = false});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: (() {
            Get.back();
          }),
        ),
        centerTitle: true,
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Pilih Virtual Account",
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
            return CustomLoading();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: AppConstants.virtualAccountList.length,
            itemBuilder: (context, index) {
              VirtualAccount item = AppConstants.virtualAccountList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: GestureDetector(
                  onTap: () {
                    AlertDialogCustom.showAlertDialog(
                      context: context,
                      onYes: () => transaction(typeVA: item.typeVA, bankFullName: item.fullName),
                      title: "Pembayaran ${item.name}",
                      content: 'Apakah anda yakin?',
                    );
                  },
                  child: ArrowOptionCard(
                    text: item.name,
                    iconsLeading: item.icon,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
