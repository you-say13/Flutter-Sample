import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_sample/presentation/Widgets/grid_view.dart';
import 'package:riverpod_sample/presentation/user_list_view_model.dart';

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
              title: Text(userInfo.name),
              subtitle: Text(userInfo.email),
              trailing: IconButton(
                onPressed: () {
                  _isShowDescription(userInfo.id!);
                },
                icon: const Icon(Icons.arrow_drop_down),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(userInfo.name),
                    content: Text('Email: ${userInfo.email}'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
            user.viewState
                ? Column(
                    children: [
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
              context.push('/insert');
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
