import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sample/domain/model/user.dart';
import 'package:riverpod_sample/domain/service/user_repository.dart';
import 'package:riverpod_sample/domain/service/validator.dart';

part 'insert_user_view_model.g.dart';

final CollectionReference users = FirebaseFirestore.instance.collection("Users");

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
