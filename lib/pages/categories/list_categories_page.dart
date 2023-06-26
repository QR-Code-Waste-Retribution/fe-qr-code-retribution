import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/categories_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/utils/number_format_price.dart';

class ListCategoriesPage extends StatefulWidget {
  const ListCategoriesPage({super.key});

  @override
  State<ListCategoriesPage> createState() => _ListCategoriesPageState();
}

class _ListCategoriesPageState extends State<ListCategoriesPage> {
  final CategoriesProvider _categoriesProvider = Get.find<CategoriesProvider>();
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  Size device = const Size(0, 0);

  @override
  void initState() {
    _categoriesProvider.getAllCategories(districtId: _authProvider.districtId!);
    super.initState();
  }

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
                  Obx(
                    () => Table(
                      textDirection: TextDirection.ltr,
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
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
                              padding:
                                  const EdgeInsets.only(bottom: 20, top: 20),
                              child: Text(
                                'Kategori',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20, top: 20),
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
                        for (var item in _categoriesProvider
                            .getCategoriesList.categories)
                          tableRowMasyarakat(
                            category: item.name!,
                            price:
                                '${NumberFormatPrice().formatPrice(price: item.price)}/bulan',
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
