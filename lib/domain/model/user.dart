import 'package:freezed_annotation/freezed_annotation.dart';

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

@immutable
@JsonSerializable()
class User {
  final String? id;
  final String name;
  final String? username;
  final String age;
  final String email;
  final Address address;
  final String phone;
  final String? companyName;
  final DateTime birthDay;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const User({
    this.id,
    required this.name,
    this.username,
    required this.age,
    required this.email,
    required this.address,
    required this.phone,
    this.companyName,
    required this.birthDay,
    required this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? name,
    String? username,
    String? age,
    String? email,
    Address? address,
    String? phone,
    String? companyName,
    DateTime? birthDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id,
        name: name ?? this.name,
        username: username,
        age: age ?? this.age,
        email: email ?? this.email,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        companyName: companyName,
        birthDay: birthDay ?? this.birthDay,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt,
      );

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
  }

  return resList;
}
