class PrefPaymentMethodPage {
  PrefPaymentMethodPage({
    required this.pemungut,
    required this.masyarakat,
  });
  late final RolePayment pemungut;
  late final RolePayment masyarakat;
  
  PrefPaymentMethodPage.fromJson(Map<String, dynamic> json){
    pemungut = RolePayment.fromJson(json['pemungut']);
    masyarakat = RolePayment.fromJson(json['masyarakat']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pemungut'] = pemungut.toJson();
    _data['masyarakat'] = masyarakat.toJson();
    return _data;
  }
}

class RolePayment {
  RolePayment({
    required this.header,
    required this.titleBody,
    required this.option,
  });
  late final String header;
  late final String titleBody;
  late final List<Option> option;
  
  RolePayment.fromJson(Map<String, dynamic> json){
    header = json['header'];
    titleBody = json['title_body'];
    option = List.from(json['option']).map((e)=>Option.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['header'] = header;
    _data['title_body'] = titleBody;
    _data['option'] = option.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Option {
  Option({
    required this.title,
    required this.body,
    required this.targetUrl,
  });
  late final String title;
  late final String body;
  late final String targetUrl;
  
  Option.fromJson(Map<String, dynamic> json){
    title = json['title'];
    body = json['body'];
    targetUrl = json['target_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['body'] = body;
    _data['target_url'] = targetUrl;
    return _data;
  }
}