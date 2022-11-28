import 'package:discord_clone/models/appuser/state.dart';
import 'package:discord_clone/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
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
    return StreamProvider<User?>(
      initialData: null,
      create: (context) => FirebaseAuth.instance.authStateChanges(),
      child: StateNotifierProvider<AppUserState, AppUser?>(
        create: (context) => AppUserState(),
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData.light(
            useMaterial3: true,
            // primarySwatch: Colors.teal,
          ),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          themeMode: ThemeMode.dark,
          routerConfig: router,
        ),
      ),
    );
  }
}
