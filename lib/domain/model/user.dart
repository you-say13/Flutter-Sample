import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@JsonSerializable()
class Address {
  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
  });

  final String street;
  final String suite;
  final String city;
  final String zipcode;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

DateTime? fromNullableTimestamp(Timestamp? timestamp) {
  debugPrint("fromNullableTimestamp");
  DateTime? dateTime = timestamp?.toDate();
  return dateTime;
}

Timestamp? toNullableTimestamp(DateTime? createdAt) {
  debugPrint("toNullableTimestamp");
  Timestamp? timestamp = createdAt == null ? null : Timestamp.fromDate(createdAt);
  return timestamp;
}

DateTime fromTimestamp(Timestamp timestamp) {
  debugPrint("fromTimestamp");
  DateTime? dateTime = timestamp.toDate();
  return dateTime;
}

Timestamp toTimestamp(DateTime createdAt) {
  debugPrint("toTimestamp");
  Timestamp? timestamp = Timestamp.fromDate(createdAt);
  return timestamp;
}

@freezed
class User with _$User {
  const factory User({
    String? id,
    required String name,
    String? username,
    required String age,
    required String email,
    required Address address,
    required String phone,
    String? companyName,
    @JsonKey(fromJson: fromTimestamp, toJson: toTimestamp) required DateTime birthDay,
    @JsonKey(fromJson: fromTimestamp, toJson: toTimestamp) required DateTime createdAt,
    @JsonKey(fromJson: fromNullableTimestamp, toJson: toNullableTimestamp) DateTime? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  String toString() {
    // TODO: implement toString
    return "id: $id, name: $name, username: $username, email: $email";
  }
}

Map<String, String> userGenerator({bool? isId}) {
  Map<String, String> resList;
  if (isId != null && isId) {
    resList = {
      "id": "識別子",
      "name": "氏名",
      "userName": "ニックネーム",
      "age": "年齢",
      "email": "Eメール",
      "phone": "電話番号",
      "zipCode": "郵便番号",
      "city": "都道府県",
      "suite": "県庁所在地",
      "street": "市区町村",
      "companyName": "会社名",
      "birthDay": "生年月日",
      "createdAt": "作成日",
      "updatedAt": "更新日",
    };
  } else {
    resList = {
      "name": "山田　太郎",
      "userName": "タロー",
      "age": "XX",
      "email": "XXX@XX.XX",
      "phone": "XXX-XXXX-XXXX",
      "zipCode": "XXX-XXXX",
      "city": "XX県",
      "suite": "XX市",
      "street": "XX-X-X",
      "companyName": "XX株式会社",
      "birthDay": "XX年XX月XX日",
    };
  }

  return resList;
}
