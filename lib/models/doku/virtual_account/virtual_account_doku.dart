import './order.dart';
import './virtual_account_info.dart';

class VirtualAccountDoku {
  Order? order;
  VirtualAccountInfo? virtualAccountInfo;

  VirtualAccountDoku({this.order, this.virtualAccountInfo});

  VirtualAccountDoku.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    virtualAccountInfo = json['virtual_account_info'] != null
        ? VirtualAccountInfo.fromJson(json['virtual_account_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (virtualAccountInfo != null) {
      data['virtual_account_info'] = virtualAccountInfo!.toJson();
    }
    return data;
  }
}

