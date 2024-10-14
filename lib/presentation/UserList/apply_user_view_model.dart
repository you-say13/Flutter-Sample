import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sample/domain/model/user.dart';
import 'package:riverpod_sample/domain/repository/user_repository.dart';
import 'package:riverpod_sample/domain/service/CRUDController.dart';

part 'apply_user_view_model.g.dart';

final CollectionReference users = FirebaseFirestore.instance.collection("Users");

enum InputFieldType {
  name,
  userName,
  age,
  email,
  phone,
  zipCode,
  city,
  suite,
  street,
  companyName,
  birthDay,
}

class ErrorUser {
  ErrorUser(
      {this.nameError,
      this.userNameError,
      this.emailError,
      this.zipCodeError,
      this.suiteError,
      this.streetError,
      this.cityError,
      this.phoneError,
      this.webSiteError,
      this.companyNameError});

  late final String? nameError;
  late final String? userNameError;
  late final String? emailError;
  late final String? zipCodeError;
  late final String? suiteError;
  late final String? streetError;
  late final String? cityError;
  late final String? phoneError;
  late final String? webSiteError;
  late final String? companyNameError;
}

@riverpod
class ApplyUserViewModel extends _$ApplyUserViewModel {
  @override
  void build() {
    return;
  }

  void insertUserData({
    required String name,
    String? username,
    required String age,
    required String email,
    Address? address,
    required String phone,
    String? website,
    String? companyName,
    required DateTime birthDay,
  }) async {
    // empty return block
    if (name.isEmpty) {
      return;
    }
    if (email.isEmpty) {
      return;
    }
    if (phone.isEmpty) {
      return;
    }

    debugPrint("insert!");

    // set user Type
    final user = User.fromJson(
      {
        "name": name,
        "email": email,
        "phone": phone,
        "username": username ?? "",
        "age": age,
        "companyName": companyName ?? "",
        "address": {
          "city": address?.city ?? "",
          "street": address?.street ?? "",
          "suite": address?.suite ?? "",
          "zipcode": address?.zipcode ?? "",
        },
        "birthDay": Timestamp.fromDate(birthDay!),
        "createdAt": Timestamp.fromDate(DateTime.now()),
      },
    );

    // insert fireStore
    CRUDController().insert(user);

    // reload homeView(userRepository data's)
    ref.invalidate(userRepositoryProvider);
  }

  void updateUserData({
    String? id,
    required String name,
    String? username,
    required String age,
    required String email,
    Address? address,
    required String phone,
    String? website,
    String? companyName,
    required DateTime createdAt,
    required DateTime birthDay,
  }) async {
    // empty return block
    if (name.isEmpty) {
      return;
    }
    if (email.isEmpty) {
      return;
    }
    if (phone.isEmpty) {
      return;
    }

    debugPrint("update!");

    // set user Type
    final user = User.fromJson(
      {
        "id": id,
        "name": name,
        "email": email,
        "age": age,
        "phone": phone,
        "username": username ?? "",
        "companyName": companyName ?? "",
        "address": {
          "city": address?.city ?? "",
          "street": address?.street ?? "",
          "suite": address?.suite ?? "",
          "zipcode": address?.zipcode ?? "",
        },
        "birthDay": Timestamp.fromDate(birthDay),
        "createdAt": Timestamp.fromDate(createdAt),
        "updatedAt": Timestamp.fromDate(DateTime.now())
      },
    );

    // insert fireStore
    CRUDController().update(user);

    // reload homeView(userRepository data's)
    ref.invalidate(userRepositoryProvider);
  }
}
