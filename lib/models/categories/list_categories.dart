import 'package:qr_code_app/models/categories/category.dart';

class ListCategories {
  late final List<Category> categories;

  ListCategories({required this.categories});

  ListCategories.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invoices'] = categories.map((v) => v.toJson()).toList();
    return data;
  }
}
