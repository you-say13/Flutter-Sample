import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sample/domain/model/user.dart';

part 'user_repository.g.dart';

final CollectionReference users = FirebaseFirestore.instance.collection("Users");

@riverpod
Future<List<User>> userRepository(UserRepositoryRef ref) async {
  // var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
  // final response = await http.get(url);
  // List<dynamic> jsonList = json.decode(response.body);
  // return jsonList.map((json) => User.fromJson(json)).toList();
  return getUsers();
}

Future<List<User>> getUsers() async {
  QuerySnapshot qs = await users.get();
  debugPrint('get user length: ${qs.docs.length}');
  return qs.docs.map((doc) {
    final Map<String, dynamic> joinMap = {"id": doc.id, ...doc.data() as Map<String, dynamic>};
    debugPrint('get user jsonData: $joinMap');
    User user = User.fromJson(joinMap);
    debugPrint("get user desc: $user");
    return user;
  }).toList();
}
