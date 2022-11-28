import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/models/appuser/state.dart';
import 'package:discord_clone/pages/auth.dart';
import 'package:discord_clone/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: "/",
  redirect: (context, state) {
    final user = context.watch<User?>();
    if (user == null) {
      return "/auth";
    }
    final appuser = context.watch<AppUserState>();
    appuser.signIn(user.uid);
    return "/";
  },
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (context, state) => const TimelinePage(),
    ),
    GoRoute(
      path: "/auth",
      builder: (context, state) => AuthPage(),
    )
  ],
);
