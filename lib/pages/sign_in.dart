import 'package:discord_clone/parts/layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../models/appuser/state.dart';

class SignInPage extends HookWidget {
  SignInPage({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final appUserState = context.read<AppUserState>();

    Future<void> signIn() async {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        final User? user = credential.user;
        if (user == null) {
          return;
        }
        appUserState.signIn(user?.uid ?? "", user.displayName ?? '');
      } on FirebaseAuthException catch (e) {
        print(e);
        print(e.message);
        print(e.stackTrace);
      }
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
                      controller: emailController,
                      autofillHints: const [AutofillHints.email],
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
                      autofillHints: const [AutofillHints.password],
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
                      onPressed: signIn,
                      child: const Text("Sign in"),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          context.go('/auth/sign_up');
                        },
                        child: const Text('Sign up page'))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
