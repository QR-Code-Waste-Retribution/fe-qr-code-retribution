import './order.dart';
import './virtual_account_info.dart';

class Bank {
  String? paymentUrl;
  BankName? bankName;
  String? vaType;

  Bank({this.paymentUrl, this.bankName, this.vaType});

  Bank.fromJson(Map<String, dynamic> json) {
    paymentUrl = json['payment.url'];
    bankName = json['bank_name'] != null
        ? BankName.fromJson(json['bank_name'])
        : null;
    vaType = json['va_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment.url'] = paymentUrl;
    if (bankName != null) {
      data['bank_name'] = bankName!.toJson();
    }
    data['va_type'] = vaType;
    return data;
  }
}

class BankName {
  String? fullName;
  String? shortName;

  BankName({this.fullName, this.shortName});

  BankName.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['short_name'] = shortName;
    return data;
  }
}

class VirtualAccountDoku {
  Order? order;
  VirtualAccountInfo? virtualAccountInfo;
  Bank? bank;
  int? merchantTransactionId;

  VirtualAccountDoku(
      {this.order,
      this.virtualAccountInfo,
      this.bank,
      this.merchantTransactionId});

  VirtualAccountDoku.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    virtualAccountInfo = json['virtual_account_info'] != null
        ? VirtualAccountInfo.fromJson(json['virtual_account_info'])
        : null;
    bank = json['bank'] != null ? Bank.fromJson(json['bank']) : null;
    merchantTransactionId = json['merchant.transaction_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (virtualAccountInfo != null) {
      data['virtual_account_info'] = virtualAccountInfo!.toJson();
    }
    return data;
  }
}
