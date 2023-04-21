import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class HistoryPaymentPage extends StatefulWidget {
  const HistoryPaymentPage({super.key});

  @override
  State<HistoryPaymentPage> createState() => _HistoryPaymentPageState();
}

class _HistoryPaymentPageState extends State<HistoryPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "History Pembayaran",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
        children: [
          Text('History Payment Page'),
        ],
      ),
    );
  }
}
