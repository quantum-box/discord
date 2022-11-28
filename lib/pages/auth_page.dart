import 'package:discord_clone/layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../models/appuser/state.dart';

class AuthPage extends HookWidget {
  AuthPage({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    Future<void> signIn() async {
      print("signin");
      if (!formKey.currentState!.validate()) {
        return;
      }
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        final User? user = credential.user;

        final appUserState = context.read<AppUserState>();
        appUserState.signIn(user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
        print(e.message);
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

    if (context.watch<User?>() != null) {
      context.go("/");
    }

    return Layout(
        title: "sign in",
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  onPressed: signIn,
                  child: const Text("Sign in"),
                )
              ],
            ),
          ),
        ));
  }
}
