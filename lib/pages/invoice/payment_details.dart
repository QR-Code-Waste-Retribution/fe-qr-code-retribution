import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
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
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: (() {
            setState(() {
              Navigator.pop(context);
            });
          }),
        ),
        title: Text(
          "Rincinan Pembayaran",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        width: device.width,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  color: thirdColor,
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  color: whiteColor,
                  size: 60,
                ),
              ),
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  color: thirdColor,
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Column(
                  children: [
                    
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
