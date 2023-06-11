import 'package:qr_code_app/models/geographic/district.dart';
import 'package:qr_code_app/models/geographic/sub_district.dart';

class AuthData {
  AuthData({
    required this.accessToken,
    required this.credentialToken,
    required this.tokenType,
    required this.user,
  });
  late final String accessToken;
  late final CredentialToken? credentialToken;
  late final String tokenType;
  late final User? user;

  AuthData.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    credentialToken = CredentialToken.fromJson(json['credential_token']);
    tokenType = json['token_type'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['access_token'] = accessToken;
    _data['credential_token'] = credentialToken?.toJson();
    _data['token_type'] = tokenType;
    _data['user'] = user?.toJson();
    return _data;
  }
}

class CredentialToken {
  CredentialToken({
    required this.id,
    required this.userId,
    required this.clientId,
    required this.name,
    required this.scopes,
    required this.revoked,
    required this.createdAt,
    required this.updatedAt,
    required this.expiresAt,
  });
  late final String id;
  late final int userId;
  late final String clientId;
  late final String name;
  late final List<dynamic> scopes;
  late final bool revoked;
  late final String createdAt;
  late final String updatedAt;
  late final String expiresAt;

  CredentialToken.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    clientId = json['client_id'];
    name = json['name'];
    scopes = List.castFrom<dynamic, dynamic>(json['scopes']);
    revoked = json['revoked'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['client_id'] = clientId;
    _data['name'] = name;
    _data['scopes'] = scopes;
    _data['revoked'] = revoked;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['expires_at'] = expiresAt;
    return _data;
  }
}

class User {
  User({
    this.id,
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
    this.createdAt,
    this.updatedAt,
    this.role,
    this.district,
    this.subDistrict,
    this.urbanVillage,
  });
  late final int? id;
  late final String? uuid;
  late final String? name;
  late final String? email;
  late final String? username;
  late final String? nik;
  late final String? gender;
  late final String? address;
  late final String? phoneNumber;
  late final String? emailVerifiedAt;
  late final int? subDistrictId;
  late final int? districtId;
  late final int? roleId;
  late final String? createdAt;
  late final String? updatedAt;
  late final Role? role;
  late final District? district;
  late final SubDistrict? subDistrict;
  late final String? urbanVillage;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    email = json['email'] ?? '';
    username = json['username'];
    nik = json['nik'];
    gender = json['gender'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    emailVerifiedAt = json['email_verified_at'] ?? '';
    subDistrictId = json['sub_district_id'];
    districtId = json['district_id'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = (json['role'] != null ? Role.fromJson(json['role']) : null)!;
    district = (json['district'] != null
        ? District.fromJson(json['district'])
        : null)!;
    subDistrict = (json['sub_district'] != null
        ? SubDistrict.fromJson(json['sub_district'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uuid'] = uuid;
    _data['name'] = name;
    _data['email'] = email;
    _data['username'] = username;
    _data['nik'] = nik;
    _data['gender'] = gender;
    _data['address'] = address;
    _data['phoneNumber'] = phoneNumber;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['sub_district_id'] = subDistrictId;
    _data['district_id'] = districtId;
    _data['role_id'] = roleId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['role'] = role;
    _data['district'] = district;
    _data['sub_district'] = subDistrict;
    return _data;
  }
}

class Role {
  Role({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
