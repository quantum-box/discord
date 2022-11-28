import 'package:discord_clone/pages/auth_page.dart';
import 'package:discord_clone/pages/timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: "/",
  redirect: (context, state) {
    final user = context.watch<User?>();
    print(user);
    if (user == null) {
      return "/auth";
    }
    return null;
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
