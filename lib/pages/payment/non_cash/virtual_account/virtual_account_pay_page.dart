import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/button_copy.dart';
import 'package:qr_code_app/components/molekuls/countdown/countdown.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class VirtualAccountPayPage extends StatefulWidget {
  const VirtualAccountPayPage({super.key});

  @override
  State<VirtualAccountPayPage> createState() => _VirtualAccountPayPageState();
}


class _VirtualAccountPayPageState extends State<VirtualAccountPayPage> {
  final List<dynamic> _data = [];

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
          "Pembayaran Virtual Account BRI",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: countDownBackgroundColor,
            ),
            child: const CountDown(),
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
          paymentStep(),
        ],
      ),
    );
  }

  ExpansionPanelList paymentStep() {
    return ExpansionPanelList(
          animationDuration: const Duration(milliseconds: 700),
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _data[index].isExpanded = !isExpanded;
            });
          },
          children: _data.map<ExpansionPanel>((dynamic item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
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
        );
  }

  Container virtualAccountInfo() {
    return Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
                        'Bank Rakyat Indonesia',
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
                    '1236 2600 0001 1822',
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const ButtonCopy(textToCopy: '1236260000011822',),
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
                'Kode Pesanan : INV-39028-00299',
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
                    'IDR 20,000',
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
                'Anton Budiman',
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
                'anton@example.com',
                style: secondaryTextStyle.copyWith(
                  color: secondaryTextColor,
                ),
              ),
            ],
          ),
        );
  }
}
