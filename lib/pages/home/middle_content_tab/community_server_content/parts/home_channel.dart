import 'package:flutter/material.dart';

class HomeChannel extends StatelessWidget {
  const HomeChannel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Highlight",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text("Home"),
              ],
            ),
          ),
        )
      ],
    );
  }
}
