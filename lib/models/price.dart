class Price {
  late final int normalPrice;
  late final String formatedPrice;

  Price({required this.normalPrice, required this.formatedPrice});

  Price.fromJson(Map<String, dynamic> json) {
    normalPrice = json['normal_price'];
    formatedPrice = json['formated_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['normal_price'] = this.normalPrice;
    data['formated_price'] = this.formatedPrice;
    return data;
  }
}
