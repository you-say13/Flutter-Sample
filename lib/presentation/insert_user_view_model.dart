import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sample/domain/model/user.dart';
import 'package:riverpod_sample/domain/repository/CRUDController.dart';
import 'package:riverpod_sample/domain/service/user_repository.dart';

part 'insert_user_view_model.g.dart';

final CollectionReference users = FirebaseFirestore.instance.collection("Users");

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
class InsertUserViewModel extends _$InsertUserViewModel {
  @override
  void build() {
    return;
  }

  void insertUserData({
    required String name,
    String? username,
    required String email,
    Address? address,
    required String phone,
    String? website,
    String? companyName,
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
        "companyName": companyName ?? "",
        "address": {
          "city": address?.city ?? "",
          "street": address?.street ?? "",
          "suite": address?.suite ?? "",
          "zipcode": address?.zipcode ?? "",
        },
      },
    );

    // insert fireStore
    CRUDController().insert(user);

    // reload homeView(userRepository data's)
    ref.invalidate(userRepositoryProvider);
  }
}
