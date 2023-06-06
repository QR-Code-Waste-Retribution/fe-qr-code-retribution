import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/button_copy.dart';
import 'package:qr_code_app/components/molekuls/countdown/countdown.dart';
import 'package:qr_code_app/components/atoms/custom_loading.dart';

import 'package:qr_code_app/models/doku/virtual_account/api/virtual_account_payment.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';

import 'package:qr_code_app/services/providers/doku_provider.dart';
import 'package:qr_code_app/services/providers/socket_provider.dart';
import 'package:qr_code_app/services/providers/transaction_provider.dart';

import 'package:qr_code_app/utils/number_format_price.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class VirtualAccountPayPage extends StatefulWidget {
  const VirtualAccountPayPage({super.key});

  @override
  State<VirtualAccountPayPage> createState() => _VirtualAccountPayPageState();
}

class _VirtualAccountPayPageState extends State<VirtualAccountPayPage> {
  final DokuProvider _dokuProvider = Get.find<DokuProvider>();

  final SocketProvider _socketProvider = Get.find<SocketProvider>();

  final TransactionProvider _transactionProvider =
      Get.find<TransactionProvider>();

  final AuthProvider _authProvider = Get.find<AuthProvider>();

  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    _dokuProvider.isLoading.value = true;
    _dokuProvider
        .getApiPayDokuDirectVirtualAccount(
            url: _transactionProvider.getURLPaymentAPIDokuVA!)
        .then((value) => _dokuProvider.isLoading.value = false);

    _socketProvider.initSocketIO(
      uuid: _authProvider.getUUID,
      typeOfChannel: 'va',
    );
  }

  @override
  void dispose() {
    super.dispose();
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
            "Pembayaran Virtual Account",
            style: primaryTextStyle.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              color: whiteColor,
              fontSize: 16,
            ),
          ),
        ),
        body: Obx(() {
          if (_dokuProvider.isLoading.value) {
            return CustomLoading(
              textColor: primaryColor,
              loadingColor: primaryColor,
            );
          }
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            children: [
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: _socketProvider.getVAStatus
                        ? secondaryColor
                        : countDownBackgroundColor,
                  ),
                  child: _socketProvider.getVAStatus
                      ? Text(
                          'Pembayaran Berhasil',
                          style: whiteTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : CountDown(
                          expiredDateAPI: _dokuProvider.getVirtualAccountPayment
                              .virtualAccountInfo?.createdDateUtc,
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              customerDesc(),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Silahkan Transfer ke',
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              virtualAccountInfo(),
              const SizedBox(
                height: 15,
              ),
              paymentStep(),
            ],
          );
        }));
  }

  ExpansionPanelList paymentStep() {
    return ExpansionPanelList(
      animationDuration: const Duration(milliseconds: 700),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _dokuProvider.getVirtualAccountPayment.paymentInstruction?[index]
              .isExpanded = !isExpanded;
        });
      },
      children: _dokuProvider.getVirtualAccountPayment.paymentInstruction
          .map<ExpansionPanel>((PaymentInstruction item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                '${item.channel}',
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          },
          body: ListView.builder(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: item.step?.length,
            itemBuilder: (context, index) {
              final step = item.step?[index];
              return Container(
                width: 200,
                margin: const EdgeInsets.only(top: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${index + 1}. ',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        step!,
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          isExpanded: item.isExpanded!,
        );
      }).toList(),
    );
  }

  Container virtualAccountInfo() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Virtual Account',
                    style: blackTextStyle.copyWith(
                      color: secondaryTextColor,
                    ),
                  ),
                  Text(
                    '${_transactionProvider.getBankVAName?.fullName}',
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Image.asset(
                'assets/icons/bri.png',
                width: 50,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Virtual Account Number / Kode Pembayaran',
            style: blackTextStyle.copyWith(
              color: secondaryTextColor,
            ),
          ),
          const SizedBox(
            height: 2.5,
          ),
          Row(
            children: [
              Text(
                _dokuProvider.virtualAccoutNumber(),
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ButtonCopy(
                textToCopy: _dokuProvider.getVirtualAccountNumber!,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container customerDesc() {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kode Pesanan : ${_dokuProvider.getVirtualAccountPayment.client?.id}',
            style: blackTextStyle.copyWith(
              color: secondaryTextColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jumlah Pembayaran',
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'IDR ${NumberFormatPrice().formatPrice(price: _dokuProvider.getVirtualAccountPayment.order?.amount)}',
                style: blackTextStyle.copyWith(
                  color: redColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: secondaryTextColor,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Nama Pelanggan',
            style: blackTextStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${_dokuProvider.getVirtualAccountPayment.customer?.name}',
            style: secondaryTextStyle.copyWith(
              color: secondaryTextColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Email',
            style: blackTextStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            _dokuProvider.getVirtualAccountPayment.customer?.email ?? '-',
            style: secondaryTextStyle.copyWith(
              color: secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
