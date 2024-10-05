// isShowDescriptionとUserの要素を持つ監視対象を作る
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sample/domain/model/user.dart';
import 'package:riverpod_sample/domain/repository/CRUDController.dart';
import 'package:riverpod_sample/domain/service/user_repository.dart';

part 'user_list_view_model.g.dart';

@immutable
class UserViewState {
  const UserViewState({
    required this.viewState,
    required this.user,
  });
  final bool viewState;
  final User user;

  UserViewState copyWith({
    bool? viewState,
    User? user,
  }) =>
      UserViewState(
        viewState: viewState ?? this.viewState,
        user: user ?? this.user,
      );

  @override
  String toString() {
    // TODO: implement toString
    return 'user: ${user.toString()}';
  }
}

@riverpod
class UserListViewModel extends _$UserListViewModel {
  @override
  List<UserViewState>? build() {
    return _fetch();
  }

  List<UserViewState>? _fetch() {
    final list = ref.watch(userRepositoryProvider);
    return list.when(
      data: (data) {
        var userList = <UserViewState>[];
        for (final user in list.value!) {
          userList.add(UserViewState(viewState: false, user: user));
        }
        return userList;
      },
      error: (err, stack) => [],
      loading: () => null,
    );
  }

  void isShow(String id) {
    final userList = state?.map(
      (user) {
        if (user.user.id == id) {
          return user.copyWith(viewState: !user.viewState);
        } else {
          return user;
        }
      },
    ).toList();
    state = [...?userList];
  }

  void delete(String id) {
    if (id == null) return;
    CRUDController().delete(id);
    ref.invalidateSelf();
  }
}
