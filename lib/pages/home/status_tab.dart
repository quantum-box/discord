import 'package:flutter/material.dart';

class StatusTab extends StatelessWidget {
  const StatusTab({super.key, this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: const [
              Text('status'),
            ],
          ),
        ),
      ),
    );
  }
}
