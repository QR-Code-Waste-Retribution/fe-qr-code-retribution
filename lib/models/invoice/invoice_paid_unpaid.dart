class InvoicePaidUnPaid {
  UsersPaidUnPaid? usersPaid;
  UsersPaidUnPaid? usersUnpaid;

  InvoicePaidUnPaid({this.usersPaid, this.usersUnpaid});

  InvoicePaidUnPaid.fromJson(Map<String, dynamic> json) {
    usersPaid = json['users.paid'] != null
        ? UsersPaidUnPaid.fromJson(json['users.paid'])
        : null;
    usersUnpaid = json['users.unpaid'] != null
        ? UsersPaidUnPaid.fromJson(json['users.unpaid'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usersPaid != null) {
      data['users.paid'] = usersPaid!.toJson();
    }
    if (usersUnpaid != null) {
      data['users.unpaid'] = usersUnpaid!.toJson();
    }
    return data;
  }
}

class UsersPaidUnPaid {
  List<Records>? records;
  int? count;

  UsersPaidUnPaid({required this.records, this.count});

  UsersPaidUnPaid.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(Records.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['records'] = records!.map((v) => v.toJson()).toList();
    data['count'] = count;
    return data;
  }
}

class Records {
  int? id;
  String? uuid;
  String? name;
  String? email;
  String? username;
  String? nik;
  String? gender;
  String? address;
  String? phoneNumber;
  String? emailVerifiedAt;
  int? subDistrictId;
  int? districtId;
  int? roleId;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? invoiceCount;

  Records(
      {this.id,
      this.uuid,
      this.name,
      this.email,
      this.username,
      this.nik,
      this.gender,
      this.address,
      this.phoneNumber,
      this.emailVerifiedAt,
      this.subDistrictId,
      this.districtId,
      this.roleId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.invoiceCount});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    nik = json['nik'];
    gender = json['gender'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    emailVerifiedAt = json['email_verified_at'];
    subDistrictId = json['sub_district_id'];
    districtId = json['district_id'];
    roleId = json['role_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    invoiceCount = json['invoiceCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['name'] = name;
    data['email'] = email;
    data['username'] = username;
    data['nik'] = nik;
    data['gender'] = gender;
    data['address'] = address;
    data['phoneNumber'] = phoneNumber;
    data['email_verified_at'] = emailVerifiedAt;
    data['sub_district_id'] = subDistrictId;
    data['district_id'] = districtId;
    data['role_id'] = roleId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['invoiceCount'] = invoiceCount;
    return data;
  }
}

