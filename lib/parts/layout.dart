import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onFloatingAction;

  const Layout({
    super.key,
    required this.title,
    required this.child,
    this.onFloatingAction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width > 560
          ? null
          : AppBar(
              title: Text(title),
            ),
      body: child,
      floatingActionButton: onFloatingAction != null
          ? FloatingActionButton(
              onPressed: onFloatingAction,
              child: const Icon(Icons.edit),
            )
          : null,
    );
  }
}
