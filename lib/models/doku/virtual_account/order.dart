
class Order {
  String? invoiceNumber;

  Order({this.invoiceNumber});

  Order.fromJson(Map<String, dynamic> json) {
    invoiceNumber = json['invoice_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invoice_number'] = invoiceNumber;
    return data;
  }
}