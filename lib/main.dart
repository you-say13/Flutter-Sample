import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_sample/domain/model/user.dart';
import 'package:riverpod_sample/firebase_options.dart';
import 'package:riverpod_sample/l10n/l10n.dart';
import 'package:riverpod_sample/presentation/apply_user_screen.dart';
import 'package:riverpod_sample/presentation/user_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: UserHomePage(),
    ),
  );
}

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'HomePage',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const UserHomeScreen(),
          ),
          routes: [
            GoRoute(
              path: 'insert',
              name: 'InsertPage',
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: const ApplyUserScreen(
                  title: 'Register User',
                ),
              ),
            ),
            GoRoute(
              path: 'edit',
              name: 'EditPage',
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: ApplyUserScreen(
                  userParam: state.extra! as User?,
                  title: 'Edit User',
                ),
              ),
            ),
          ],
        ),
      ],
    );

    return MaterialApp.router(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
    );
  }
}
