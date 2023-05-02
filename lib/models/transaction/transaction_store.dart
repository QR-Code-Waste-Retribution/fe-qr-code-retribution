class TransactionStore {
  List<InvoicesId>? invoicesId;
  double? totalAmount;
  int? masyarakatId;
  int? pemungutId;
  int? categoryId;
  int? subDistrictId;
  String? type;

  TransactionStore(
      {this.invoicesId,
      this.totalAmount,
      this.masyarakatId,
      this.pemungutId,
      this.categoryId,
      this.subDistrictId,
      this.type});

  TransactionStore.fromJson(Map<String, dynamic> json) {
    if (json['invoices_id'] != null) {
      invoicesId = <InvoicesId>[];
      json['invoices_id'].forEach((v) {
        invoicesId!.add(InvoicesId.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    masyarakatId = json['masyarakat_id'];
    pemungutId = json['pemungut_id'];
    categoryId = json['category_id'];
    subDistrictId = json['sub_district_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (invoicesId != null) {
      data['invoices_id'] = invoicesId!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = totalAmount;
    data['masyarakat_id'] = masyarakatId;
    data['pemungut_id'] = pemungutId;
    data['category_id'] = categoryId;
    data['sub_district_id'] = subDistrictId;
    data['type'] = type;
    return data;
  }
}

class InvoicesId {
  int? parents;
  List<int>? variants;

  InvoicesId({this.parents, this.variants});

  InvoicesId.fromJson(Map<String, dynamic> json) {
    parents = json['parents'];
    variants = json['variants'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parents'] = parents;
    data['variants'] = variants;
    return data;
  }
}
