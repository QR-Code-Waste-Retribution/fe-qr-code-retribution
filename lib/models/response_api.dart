class ResponseAPI {
  late final dynamic data;
  late final bool success;
  late final String message;

  ResponseAPI.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['success'] = success;
    _data['message'] = message;
    return _data;
  }
}
