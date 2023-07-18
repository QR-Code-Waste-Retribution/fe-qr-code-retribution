import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/geographic/sub_district.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/services/repositories/geographic_provider.dart';

class GeographicProvider extends GetxController {
  final GeographicRepositories geographicRepositories =
      GeographicRepositories();

  Rx<ListSubDistrict> listSubDistrict = ListSubDistrict(subDistricts: []).obs;

  RxBool isLoading = false.obs;

  List<SubDistrict>? get getListSubDistricts =>
      listSubDistrict.value.subDistricts;

  Future<void> getAllSubDistrictByDistrictId({required int districtId}) async {
    try {
      ResponseAPI response =
          await geographicRepositories.getSubDistricts(districtId: districtId);
      listSubDistrict.value = ListSubDistrict.fromJson(response.data);
      isLoading.value = false;

      update();
    } catch (e) {

      isLoading.value = false;
      update();
      Get.snackbar(
        'Error',
        'Failed to get api : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }
}
