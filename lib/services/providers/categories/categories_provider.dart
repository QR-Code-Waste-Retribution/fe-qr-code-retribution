import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/categories/category.dart';
import 'package:qr_code_app/models/categories/list_categories.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/services/repositories/categories_repositories.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class CategoriesProvider extends GetxController {
  final Rx<ListCategories> _categories =
      ListCategories(categories: [Category(id: 1, name: "Test")]).obs;

  final CategoriesRepositories _categoriesRepositories =
      CategoriesRepositories();

  RxString dropdownValue = '1'.obs;

  String get getDropdownValue => dropdownValue.value;

  ListCategories get getCategoriesList => _categories.value;

  RxInt priceSelected = 0.obs;

  RxBool isLoading = false.obs;

  bool get getIsLoading => isLoading.value;

  Rx<Category?> categorySelected = Rx<Category?>(null);

  Category? get getCategorySelected => categorySelected.value;

  String get getPriceSelectedCategory => priceSelected.value.toString();

  void priceSelectedCategories({required int idSelected}) {
    for (var category in getCategoriesList.categories) {
      if (category.id == idSelected) {
        priceSelected.value = category.price!;
        categorySelected.value = category;
      }
    }
  }

  Future<void> getAllCategories({required int districtId}) async {
    try {
      ResponseAPI response =
          await _categoriesRepositories.allCategories(districtId: districtId);

      _categories.value = ListCategories.fromJson(response.data);
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      Get.snackbar(
        'Error',
        'Failed to get all categories : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }

  Future<void> getAllCategoriesMonthly({required int districtId}) async {
    try {
      ResponseAPI response =
          await _categoriesRepositories.allCategoriesMonthly(districtId: districtId);

      _categories.value = ListCategories.fromJson(response.data);
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      Get.snackbar(
        'Error',
        'Failed to get all categories : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }

  Future<void> getAllAddtionalCategories({required int districtId}) async {
    try {
      ResponseAPI response = await _categoriesRepositories
          .allAdditionalCategoriesByDistrictId(districtId: districtId);

      _categories.value = ListCategories.fromJson(response.data);

      isLoading.value = false;

      Get.snackbar(
        "Success",
        response.message,
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 5,
      );
      update();
    } catch (e) {

      isLoading.value = false;
      update();
      Get.snackbar(
        'Error',
        'Failed to get all categories : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }
}
