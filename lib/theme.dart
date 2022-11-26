import 'package:flutter/material.dart';

class ThemeProvider extends StatelessWidget {
  final Widget child;

  const ThemeProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(
        useMaterial3: true,
        // primarySwatch: Colors.teal,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: child,
    );
  }
}
