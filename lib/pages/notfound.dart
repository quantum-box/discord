import 'package:discord_clone/models/appuser/datasource.dart';
import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/models/invitation/datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NotFoundPage extends HookWidget {
  const NotFoundPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("not found"),
                ElevatedButton(
                    onPressed: () {
                      context.go("/auth/sign_in");
                    },
                    child: Text("Return back sign in"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
