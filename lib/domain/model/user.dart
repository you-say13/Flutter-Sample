import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class Address {
  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    this.geo,
  });

  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo? geo;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Geo {
  Geo({
    required this.lat,
    required this.lng,
  });
  final String lat;
  final String lng;

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
  Map<String, dynamic> toJson() => _$GeoToJson(this);
}

@immutable
@JsonSerializable()
class User {
  final String? id;
  final String name;
  final String? username;
  final String email;
  final Address address;
  final String phone;
  final String? website;
  final String? companyName;

  const User({
    this.id,
    required this.name,
    this.username,
    required this.email,
    required this.address,
    required this.phone,
    this.website,
    this.companyName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? name,
    String? username,
    String? email,
    Address? address,
    String? phone,
    String? website,
    String? companyName,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        companyName: companyName ?? this.companyName,
      );

  @override
  String toString() {
    // TODO: implement toString
    return "id: $id, name: $name, username: $username, email: $email";
  }
}
