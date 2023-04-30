class Checkout {
  List<String>? message;
  int? transactionId;
  Response? response;

  Checkout({this.message, this.response});

  Checkout.fromJson(Map<String, dynamic> json) {
    message = json['message'].cast<String>();
    transactionId = json['transaction_id'];
    response =
        json['response'] != null ? Response.fromJson(json['response']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['transaction_id'] = transactionId;
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class Response {
  Order? order;
  Payment? payment;
  Customer? customer;
  double? uuid;
  Headers? headers;

  Response({this.order, this.payment, this.customer, this.uuid, this.headers});

  Response.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    payment =
        json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    uuid = json['uuid'];
    headers =
        json['headers'] != null ? Headers.fromJson(json['headers']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['uuid'] = uuid;
    if (headers != null) {
      data['headers'] = headers!.toJson();
    }
    return data;
  }
}

class Order {
  String? amount;
  String? invoiceNumber;
  String? currency;
  String? sessionId;
  String? callbackUrl;
  String? callbackUrlCancel;
  List<LineItems>? lineItems;
  String? language;
  bool? disableRetryPayment;
  bool? autoRedirect;

  Order(
      {this.amount,
      this.invoiceNumber,
      this.currency,
      this.sessionId,
      this.callbackUrl,
      this.callbackUrlCancel,
      this.lineItems,
      this.language,
      this.disableRetryPayment,
      this.autoRedirect});

  Order.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    invoiceNumber = json['invoice_number'];
    currency = json['currency'];
    sessionId = json['session_id'];
    callbackUrl = json['callback_url'];
    callbackUrlCancel = json['callback_url_cancel'];
    if (json['line_items'] != null) {
      lineItems = <LineItems>[];
      json['line_items'].forEach((v) {
        lineItems!.add(LineItems.fromJson(v));
      });
    }
    language = json['language'];
    disableRetryPayment = json['disable_retry_payment'];
    autoRedirect = json['auto_redirect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['invoice_number'] = invoiceNumber;
    data['currency'] = currency;
    data['session_id'] = sessionId;
    data['callback_url'] = callbackUrl;
    data['callback_url_cancel'] = callbackUrlCancel;
    if (lineItems != null) {
      data['line_items'] = lineItems!.map((v) => v.toJson()).toList();
    }
    data['language'] = language;
    data['disable_retry_payment'] = disableRetryPayment;
    data['auto_redirect'] = autoRedirect;
    return data;
  }
}

class LineItems {
  String? name;
  int? quantity;
  String? price;

  LineItems({this.name, this.quantity, this.price});

  LineItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}

class Payment {
  List<String>? paymentMethodTypes;
  int? paymentDueDate;
  String? tokenId;
  String? url;
  String? expiredDate;

  Payment(
      {this.paymentMethodTypes,
      this.paymentDueDate,
      this.tokenId,
      this.url,
      this.expiredDate});

  Payment.fromJson(Map<String, dynamic> json) {
    paymentMethodTypes = json['payment_method_types'].cast<String>();
    paymentDueDate = json['payment_due_date'];
    tokenId = json['token_id'];
    url = json['url'];
    expiredDate = json['expired_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_method_types'] = paymentMethodTypes;
    data['payment_due_date'] = paymentDueDate;
    data['token_id'] = tokenId;
    data['url'] = url;
    data['expired_date'] = expiredDate;
    return data;
  }
}

class Customer {
  String? id;
  String? email;
  String? name;
  String? address;

  Customer({this.id, this.email, this.name, this.address});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['address'] = address;
    return data;
  }
}

class Headers {
  String? requestId;
  String? signature;
  String? date;
  String? clientId;

  Headers({this.requestId, this.signature, this.date, this.clientId});

  Headers.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    signature = json['signature'];
    date = json['date'];
    clientId = json['client_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_id'] = requestId;
    data['signature'] = signature;
    data['date'] = date;
    data['client_id'] = clientId;
    return data;
  }
}
