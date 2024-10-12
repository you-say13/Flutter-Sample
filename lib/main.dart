import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_sample/domain/model/user.dart';
import 'package:riverpod_sample/firebase_options.dart';
import 'package:riverpod_sample/l10n/l10n.dart';
import 'package:riverpod_sample/presentation/PokemonList/pokemon_list_screen.dart';
import 'package:riverpod_sample/presentation/UserList/apply_user_screen.dart';
import 'package:riverpod_sample/presentation/UserList/user_list_screen.dart';

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

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.person), label: 'User'),
          NavigationDestination(icon: Icon(Icons.sd_card), label: 'pokemon'),
        ],
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final shellGoRouter = GoRouter(initialLocation: '/home', routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppNavigationBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
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
          ),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/pokemon',
              name: "pokemonList",
              pageBuilder: (context, state) => MaterialPage(
                child: const PokemonListScreen(),
              ),
            ),
          ])
        ],
      ),
    ]);

    return MaterialApp.router(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      routerDelegate: shellGoRouter.routerDelegate,
      routeInformationParser: shellGoRouter.routeInformationParser,
      routeInformationProvider: shellGoRouter.routeInformationProvider,
    );
  }
}
