class Price {
  late final int normalPrice;
  late final String formatedPrice;

  Price({required this.normalPrice, required this.formatedPrice});

  Price.fromJson(Map<String, dynamic> json) {
    normalPrice = json['normal_price'];
    formatedPrice = json['formated_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['normal_price'] = normalPrice;
    data['formated_price'] = formatedPrice;
    return data;
  }
}
