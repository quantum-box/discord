import 'package:discord_clone/pages/auth_page.dart';
import 'package:discord_clone/pages/timeline.dart';

import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: "/",
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
