import 'package:discord_clone/models/appuser/datasource.dart';
import 'package:discord_clone/models/appuser/state.dart';
import 'package:discord_clone/pages/invite.dart';
import 'package:discord_clone/pages/sign_in.dart';
import 'package:discord_clone/pages/home/home.dart';
import 'package:discord_clone/pages/sign_up.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:state_notifier/state_notifier.dart';
import 'models/appuser/entity.dart';
import 'firebase_options.dart';

import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>(
          initialData: null,
          create: (context) => FirebaseAuth.instance.authStateChanges(),
        ),
        StateNotifierProvider(create: (context) => AppUserState())
      ],
      child: const ThemeProvider(),
    );
  }
}

class ThemeProvider extends StatelessWidget {
  const ThemeProvider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData.light(
        useMaterial3: true,
        // primarySwatch: Colors.teal,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      routerConfig: GoRouter(
        initialLocation: "/",
        redirect: (context, state) {
          print(state.subloc);
          final fromp = state.subloc == '/' ? '' : '?from=${state.subloc}';

          final user = context.read<User?>();
          if (user == null) {
            if (state.subloc == '/auth/sign_up') {
              return '/auth/sign_up';
            }
            return "/auth/sign_in$fromp";
          }

          return state.queryParams['from'];
        },
        routes: <RouteBase>[
          GoRoute(
            path: "/",
            builder: (context, state) =>
                HomePage.withDependecy(user?.uid ?? ''),
          ),
          GoRoute(
            path: "/auth/sign_in",
            builder: (context, state) => SignInPage(),
          ),
          GoRoute(
            path: '/auth/sign_up',
            builder: (context, state) => SignUpPage(),
          ),
          GoRoute(
            path: '/invite/:inviteId',
            builder: (context, state) {
              final inviteId = state.params['inviteId'];
              return InvitePage(
                inviteId: inviteId,
              );
            },
          )
        ],
      ),
    );
  }
}
