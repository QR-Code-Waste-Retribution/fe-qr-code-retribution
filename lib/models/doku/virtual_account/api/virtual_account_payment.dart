class VirtualAccountPayment {
  Client? client;
  Order? order;
  VirtualAccountInfo? virtualAccountInfo;
  Customer? customer;
  late List<PaymentInstruction> paymentInstruction;

  VirtualAccountPayment(
      {this.client,
      this.order,
      this.virtualAccountInfo,
      this.customer,
      required this.paymentInstruction});

  VirtualAccountPayment.fromJson(Map<String, dynamic> json) {
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    virtualAccountInfo = json['virtual_account_info'] != null
        ? VirtualAccountInfo.fromJson(json['virtual_account_info'])
        : null;
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    if (json['payment_instruction'] != null) {
      paymentInstruction = <PaymentInstruction>[];
      json['payment_instruction'].forEach((v) {
        paymentInstruction!.add(PaymentInstruction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (virtualAccountInfo != null) {
      data['virtual_account_info'] = virtualAccountInfo!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (paymentInstruction != null) {
      data['payment_instruction'] =
          paymentInstruction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Client {
  String? id;
  String? name;

  Client({this.id, this.name});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Order {
  String? invoiceNumber;
  int? amount;

  Order({this.invoiceNumber, this.amount});

  Order.fromJson(Map<String, dynamic> json) {
    invoiceNumber = json['invoice_number'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invoice_number'] = invoiceNumber;
    data['amount'] = amount;
    return data;
  }
}

class VirtualAccountInfo {
  String? virtualAccountNumber;
  String? status;
  String? createdDate;
  String? expiredDate;
  String? expiredIn;
  String? createdDateUtc;
  String? expiredDateUtc;

  VirtualAccountInfo(
      {this.virtualAccountNumber,
      this.status,
      this.createdDate,
      this.expiredDate,
      this.expiredIn,
      this.createdDateUtc,
      this.expiredDateUtc});

  VirtualAccountInfo.fromJson(Map<String, dynamic> json) {
    virtualAccountNumber = json['virtual_account_number'];
    status = json['status'];
    createdDate = json['created_date'];
    expiredDate = json['expired_date'];
    expiredIn = json['expired_in'];
    createdDateUtc = json['created_date_utc'];
    expiredDateUtc = json['expired_date_utc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['virtual_account_number'] = virtualAccountNumber;
    data['status'] = status;
    data['created_date'] = createdDate;
    data['expired_date'] = expiredDate;
    data['expired_in'] = expiredIn;
    data['created_date_utc'] = createdDateUtc;
    data['expired_date_utc'] = expiredDateUtc;
    return data;
  }
}

class Customer {
  String? name;
  String? email;

  Customer({this.name, this.email});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}

class PaymentInstruction {
  String? channel;
  String? language;
  List<String>? step;
  bool? isExpanded;

  PaymentInstruction(
      {this.channel, this.language, this.step, this.isExpanded = false});

  PaymentInstruction.fromJson(Map<String, dynamic> json) {
    channel = json['channel'];
    language = json['language'];
    step = json['step'].cast<String>();
    isExpanded = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel'] = channel;
    data['language'] = language;
    data['step'] = step;
    return data;
  }
}
