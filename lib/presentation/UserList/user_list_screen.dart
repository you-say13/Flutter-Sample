import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_sample/domain/repository/user_repository.dart';
import 'package:riverpod_sample/domain/service/CRUDController.dart';
import 'package:riverpod_sample/presentation/UserList/user_list_view_model.dart';
import 'package:riverpod_sample/presentation/Widgets/alert_dialog.dart';
import 'package:riverpod_sample/presentation/Widgets/grid_view.dart';

class UserHomeScreen extends ConsumerStatefulWidget {
  const UserHomeScreen({super.key});

  @override
  ConsumerState<UserHomeScreen> createState() => UserHomeScreenState();
}

class UserHomeScreenState extends ConsumerState<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userList = ref.watch(userListViewModelProvider);
    Widget content;

    // TODO 一瞬取得に失敗するので修正する
    if (userList == null) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (userList.isEmpty) {
      content = const Center(
        child: Text("user is empty..."),
      );
    } else {
      content = ListView(
        children: userList.expand((user) {
          final userInfo = user.user;
          return [
            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              title: Text(userInfo.name),
              subtitle: Text(userInfo.email),
              trailing: PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: "DELETE",
                      child: Text("DELETE"),
                    ),
                    const PopupMenuItem(
                      value: "UPDATE",
                      child: Text("UPDATE"),
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == "DELETE") {
                    AlertDialogComp()
                        .alertDialog(
                      title: "ユーザー情報を削除します",
                      message: "この操作は取り消すことができません。本当にこのデータを削除しますか？",
                      context: context,
                    )
                        .then(
                      (value) async {
                        if (value) {
                          CRUDController().delete(userInfo.id!);
                          ref.invalidate(userRepositoryProvider);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("success delete user"),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("cancel delete user"),
                            ),
                          );
                        }
                      },
                    );
                  } else if (value == "UPDATE") {
                    context.go("/edit", extra: userInfo);
                  }
                },
              ),
              onTap: () {
                _isShowDescription(userInfo.id!);
              },
            ),
            user.viewState
                ? Column(
                    children: [
                      const Divider(),
                      DetailGridView(userInfo: userInfo),
                      const Divider(),
                    ],
                  )
                : const Divider(),
          ];
        }).toList(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.green,
        title: const Text(
          'UserList',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: const Icon(
          Icons.person,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.go('/insert');
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: content,
    );
  }

  void _isShowDescription(String index) {
    ref.read(userListViewModelProvider.notifier).isShow(index);
  }
}
