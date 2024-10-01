import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sample/domain/model/user.dart';
import 'package:riverpod_sample/domain/service/user_repository.dart';
import 'package:riverpod_sample/domain/service/validator.dart';
import 'package:riverpod_sample/l10n/l10n.dart';

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
  InsertUserViewModel(this.l10n);
  final L10n l10n;

  @override
  void build() {
    return;
  }

  ErrorUser checkValidation({
    required String name,
    String? username,
    required String email,
    required String zipCode,
    required String city,
    required String suite,
    required String street,
    required String phone,
    String? website,
    String? companyName,
  }) {
    ErrorUser eu = ErrorUser();
    if (Validator().defaultValidator(name)) {
      eu.nameError = l10n.nameError;
    }
    if(Validator().defaultValidator(zipCode)){
      eu.zipCodeError = l10n.zipCodeError;
    }

    return eu;
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

    // validation check
    if (Validator().defaultValidator(name)) return;
    if (Validator().emailValidator(email)) return;
    if (Validator().defaultValidator(phone)) return;

    // insert fireStore
    await users.doc().set(
      {
        "name": name,
        "email": email,
        "phone": phone,
        "username": username ?? "",
        "company": companyName ?? "",
        "address": {
          "city": address?.city ?? "",
          "street": address?.street ?? "",
          "suite": address?.suite ?? "",
          "zipcode": address?.zipcode ?? "",
        }
      },
    );

    // reload homeView(userRepository data's)
    ref.invalidate(userRepositoryProvider);
  }
}
