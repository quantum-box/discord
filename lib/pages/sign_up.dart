import 'package:discord_clone/models/appuser/datasource.dart';
import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/parts/layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../models/appuser/state.dart';

class SignUpPage extends HookWidget {
  SignUpPage({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final displayNameController = useTextEditingController();
    final appUserState = context.read<AppUserState>();

    Future<void> signUp() async {
      if (!formKey.currentState!.validate()) {
        return;
      }
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        final User? user = credential.user;
        if (user == null) {
          return;
        }
        await user.updateDisplayName(displayNameController.text);
        await AppUserDatasource(user.uid).upsert(AppUserEntity(
            id: user.uid, displayName: displayNameController.text));
        appUserState.signIn(user.uid, displayNameController.text);
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red, content: Text(e.message ?? "error")));
      }
    }

    Future<void> signOut() async {
      await FirebaseAuth.instance.signOut();
    }

    Future<void> sendPasswordResetEmail(String email) async {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      } catch (e) {}
    }

    return Layout(
        title: "sign in",
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: displayNameController,
                      decoration:
                          const InputDecoration(labelText: "Display name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: "Email"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: "Password"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: signUp,
                      child: const Text("Sign in"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
