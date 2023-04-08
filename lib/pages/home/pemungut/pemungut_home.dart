import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class PemungutHome extends StatelessWidget {
  final Size device;
  const PemungutHome({
    Key? key,
   required this.device,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Money Recapitulation
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Catatan Keuangan',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Lihat Detail',
                    style: linkTextStyle.copyWith(),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 5,
                      offset: const Offset(2, 3.5),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 15,
                      ),
                      child: Icon(
                        Icons.arrow_circle_down,
                        color: primaryColor,
                        size: 50,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total iuran yang sudah anda\nkumpulkan di bulan ini',
                          style: secondaryTextStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Rp. 640.000 -,',
                          style: blackTextStyle.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Status
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status',
                style: primaryTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 5,
                      offset: const Offset(2, 3.5),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: device.width * 0.45,
                        child: Text(
                          'Semua tagihan iuran retribusi sampah sudah lunas dan sudah disetor',
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset('assets/image/status_image.png'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
