import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/categories/list_invoices.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/services/repositories/categories_repositories.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class CategoriesProvider extends GetxController {
  final Rx<ListCategories> _categories = ListCategories(categories: []).obs;

  final CategoriesRepositories _categoriesRepositories =
      CategoriesRepositories();

  ListCategories get getCategoriesList => _categories.value;

  Future<void> getAllCategories({required int districtId}) async {
    try {
      ResponseAPI response =
          await _categoriesRepositories.allCategories(districtId: districtId);

      _categories.value = ListCategories.fromJson(response.data);

      print(_categories.toJson().toString());
      Get.snackbar(
        "Success",
        response.message,
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 5,
      );
      update();
    } catch (e) {
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
