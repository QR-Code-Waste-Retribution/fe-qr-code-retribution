import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/pages/invoice/pemungut/invoice_additional_page.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/services/providers/auth/auth_provider.dart';
import 'package:qr_code_app/services/providers/categories/categories_provider.dart';
import 'package:qr_code_app/models/categories/category.dart';

class AdditionalRetributionPage extends StatefulWidget {
  const AdditionalRetributionPage({super.key});

  @override
  State<AdditionalRetributionPage> createState() =>
      _AdditionalRetributionPageState();
}

class _AdditionalRetributionPageState extends State<AdditionalRetributionPage> {
  final CategoriesProvider _categoriesProvider = Get.find<CategoriesProvider>();
  final priceController = TextEditingController();

  final AuthProvider _authProvider = Get.find<AuthProvider>();

  Size device = const Size(0, 0);

  @override
  void initState() {
    _categoriesProvider.isLoading.value = true;
    _categoriesProvider
        .getAllAddtionalCategories(districtId: _authProvider.districtId!)
        .then((value) {
      _categoriesProvider.dropdownValue.value =
          _categoriesProvider.getCategoriesList.categories[0].id.toString();
      priceController.text =
          _categoriesProvider.getCategoriesList.categories[0].price.toString();
      _categoriesProvider.priceSelectedCategories(
        idSelected: _categoriesProvider.getCategoriesList.categories[0].id!,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    priceController.dispose();
    _categoriesProvider.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget dropdownChooseCategory() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pilih Kategori',
            style: secondaryTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
            decoration: BoxDecoration(
              color: backgroundColor6,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Obx(
              () => DropdownButton<String>(
                alignment: Alignment.bottomCenter,
                value: _categoriesProvider.getDropdownValue,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                iconSize: 24,
                borderRadius: BorderRadius.circular(20),
                underline: Container(height: 0),
                style: const TextStyle(color: Colors.deepPurple),
                onChanged: (String? newValue) {
                  _categoriesProvider.dropdownValue.value = newValue!;
                  _categoriesProvider.priceSelectedCategories(
                    idSelected: int.parse(newValue),
                  );
                  priceController.text =
                      _categoriesProvider.getPriceSelectedCategory;
                },
                items: _categoriesProvider.getCategoriesList.categories
                    .map<DropdownMenuItem<String>>((Category category) {
                  return DropdownMenuItem(
                    enabled: category.name == _categoriesProvider.dropdownValue.value
                        ? false
                        : true,
                    value: category.id.toString(),
                    child: Text(
                      "${category.name}",
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      );
    }

    Widget priceInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Harga',
              style: secondaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: backgroundColor6,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: priceController,
                        scrollPadding: const EdgeInsets.only(bottom: 40),
                        style: primaryTextStyle.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: '0',
                          prefixText: 'Rp. ',
                          hintStyle: subtitleTextStyle,
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            String newValue =
                                value.replaceAll(',', ''); // Remove commas
                            priceController.value = TextEditingValue(
                              text: newValue,
                              selection: TextSelection.fromPosition(
                                  TextPosition(
                                      offset: priceController.text.length)),
                            );
                          }
                        },
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

    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          "Tagih Iuran Retribusi Tambahan",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          dropdownChooseCategory(),
          priceInput(),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Apakah masyarakat ingin membayar retribusi sampah secara tunai sekarang?',
            style: primaryTextStyle,
          ),
          CustomButton(
            title: 'Bayar',
            width: 120,
            margin: const EdgeInsets.only(
              top: 30,
              bottom: 80,
            ),
            onPressed: () {
              Get.to(
                () => const InvoiceAdditionalPage(),
              );
            },
          ),
        ],
      ),
    );
  }
}
