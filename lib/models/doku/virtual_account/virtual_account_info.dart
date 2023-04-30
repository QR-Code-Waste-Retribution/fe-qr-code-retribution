
class VirtualAccountInfo {
  String? virtualAccountNumber;
  String? howToPayPage;
  String? howToPayApi;
  String? createdDate;
  String? expiredDate;
  String? createdDateUtc;
  String? expiredDateUtc;

  VirtualAccountInfo(
      {this.virtualAccountNumber,
      this.howToPayPage,
      this.howToPayApi,
      this.createdDate,
      this.expiredDate,
      this.createdDateUtc,
      this.expiredDateUtc});

  VirtualAccountInfo.fromJson(Map<String, dynamic> json) {
    virtualAccountNumber = json['virtual_account_number'];
    howToPayPage = json['how_to_pay_page'];
    howToPayApi = json['how_to_pay_api'];
    createdDate = json['created_date'];
    expiredDate = json['expired_date'];
    createdDateUtc = json['created_date_utc'];
    expiredDateUtc = json['expired_date_utc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['virtual_account_number'] = virtualAccountNumber;
    data['how_to_pay_page'] = howToPayPage;
    data['how_to_pay_api'] = howToPayApi;
    data['created_date'] = createdDate;
    data['expired_date'] = expiredDate;
    data['created_date_utc'] = createdDateUtc;
    data['expired_date_utc'] = expiredDateUtc;
    return data;
  }
}