# qr_code_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Container(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Image.asset('assets/image/home_image.png'),
            ),
            Positioned(
              top: 30,
              child: Container(
                width: device.width,
                padding: EdgeInsets.all(20),
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
                      margin: EdgeInsets.symmetric(vertical: 40),
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
                      margin: EdgeInsets.symmetric(vertical: 30),
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
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 10,
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
                                    Expanded(
                                      child: Text(
                                        'Total iuran yang sudah anda kumpulkan di bulan ini',
                                        style: secondaryTextStyle,
                                      ),
                                    ),
                                    Text('Rp. 640.000 -,'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );