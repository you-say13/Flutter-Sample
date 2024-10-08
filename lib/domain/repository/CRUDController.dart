import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_sample/domain/model/user.dart';

final CollectionReference users = FirebaseFirestore.instance.collection("Users");

class CRUDController {
  void insert(User user) async {
    try {
      await users.doc().set(
        {
          "name": user.name,
          "email": user.email,
          "phone": user.phone,
          "username": user.username,
          "companyName": user.companyName,
          "address": {
            "city": user.address.city,
            "street": user.address.street,
            "suite": user.address.suite,
            "zipcode": user.address.zipcode,
          },
          "birthDay": Timestamp.fromDate(user.birthDay),
          "createdAt": Timestamp.fromDate(user.createdAt),
          "updatedAt": user.updatedAt != null ? Timestamp.fromDate(user.updatedAt!) : null,
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void update(User user) async {
    try {
      await users.doc(user.id).update(
        {
          "name": user.name,
          "email": user.email,
          "phone": user.phone,
          "username": user.username,
          "companyName": user.companyName,
          "address": {
            "city": user.address.city,
            "street": user.address.street,
            "suite": user.address.suite,
            "zipcode": user.address.zipcode,
          },
          "birthDay": user.birthDay,
          "createdAt": user.createdAt,
          "updatedAt": user.updatedAt,
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void delete(String id) async {
    try {
      debugPrint("delete user id: $id");
      await users.doc(id).delete();
      debugPrint("delete user success");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
