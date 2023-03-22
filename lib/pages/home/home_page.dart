import 'package:flutter/material.dart';
import 'package:qr_code_app/data/home_menu.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size device = const Size(0, 0);
  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 0, bottom: 50),
        children: [
          Container(
            width: device.width,
            height: device.height * 1.05,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Image.asset('assets/image/home_image.png'),
                ),
                Positioned(
                  top: 0,
                  child: HomeContent(device: device),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
    required this.device,
  }) : super(key: key);

  final Size device;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: device.width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text Header
          Text(
            'Halo Petugas A',
            style: primaryTextStyle.copyWith(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          // Header Home
          Container(
            width: device.width * 0.95,
            margin: EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/image/login_image.png',
                  width: device.width * 0.325,
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Text(
                    'Selamat datang sebagai petugas di Aplikasi Retribusi Sampah Kabupaten Toba',
                    style: primaryTextStyle.copyWith(
                      color: whiteColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Home Menu Grid
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            width: device.width * 0.9,
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 5,
                  offset: const Offset(2, 3.5),
                ),
              ],
              borderRadius: BorderRadius.circular(30),
            ),
            child: HomeMenuGrid(device: device),
          ),

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
                      Container(
                        width: device.width * 0.45,
                        child: Expanded(
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
      ),
    );
  }
}

class HomeMenuGrid extends StatelessWidget {
  const HomeMenuGrid({
    Key? key,
    required this.device,
  }) : super(key: key);

  final Size device;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: EdgeInsets.only(
        top: 0,
      ),
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: Container(
            width: device.width,
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(200),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: 5,
                        offset: const Offset(2, 3.5),
                      ),
                    ],
                  ),
                  child: Icon(
                    homeMenu[index].iconImage,
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Wrap(
                  children: [
                    Text(
                      homeMenu[index].iconText,
                      textAlign: TextAlign.center,
                      style: primaryTextStyle.copyWith(
                        fontSize: 12.5,
                        color: blackColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
