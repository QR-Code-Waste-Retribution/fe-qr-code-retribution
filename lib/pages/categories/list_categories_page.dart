import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class ListCategoriesPage extends StatefulWidget {
  const ListCategoriesPage({super.key});

  @override
  State<ListCategoriesPage> createState() => _ListCategoriesPageState();
}

class _ListCategoriesPageState extends State<ListCategoriesPage> {
  Size device = const Size(0, 0);

  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: (() {
            Get.back();
          }),
        ),
      ),
      backgroundColor: secondaryColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Daftar Kategori Retribusi Sampah di Kabupaten Toba',
                    style: whiteTextStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Image.asset(
                  'assets/image/payment_method_img.png',
                  width: device.width * 0.35,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    'Berikut daftar kategori dan harga tarif dari iuran retribusi sampah kab. Toba',
                    style: primaryTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Table(
                    textDirection: TextDirection.ltr,
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          border: Border(
                            bottom: BorderSide(
                              color: blackColor,
                            ),
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 20),
                            child: Text(
                              'Kategori',
                              style: whiteTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 20),
                            child: Text(
                              "Harga",
                              style: whiteTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      tableRowMasyarakat(
                        category: 'Perumahan A',
                        price: 'Rp. 5.000/bulan',
                      ),
                      tableRowMasyarakat(
                        category: 'Perumahan B',
                        price: 'Rp. 15.000/bulan',
                      ),
                      tableRowMasyarakat(
                        category: 'Perumahan C',
                        price: 'Rp. 25.000/bulan',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow tableRowMasyarakat(
      {required String category, required String price}) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: blackColor,
          ),
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 15, right: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 15),
          child: Row(
            children: [
              Text(
                price,
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
