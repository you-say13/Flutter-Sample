// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      street: json['street'] as String,
      suite: json['suite'] as String,
      city: json['city'] as String,
      zipcode: json['zipcode'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'street': instance.street,
      'suite': instance.suite,
      'city': instance.city,
      'zipcode': instance.zipcode,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      username: json['username'] as String?,
      age: json['age'] as String,
      email: json['email'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      phone: json['phone'] as String,
      companyName: json['companyName'] as String?,
      birthDay: fromTimestamp(json['birthDay'] as Timestamp),
      createdAt: fromTimestamp(json['createdAt'] as Timestamp),
      updatedAt: fromNullableTimestamp(json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'age': instance.age,
      'email': instance.email,
      'address': instance.address,
      'phone': instance.phone,
      'companyName': instance.companyName,
      'birthDay': toTimestamp(instance.birthDay),
      'createdAt': toTimestamp(instance.createdAt),
      'updatedAt': toNullableTimestamp(instance.updatedAt),
    };
