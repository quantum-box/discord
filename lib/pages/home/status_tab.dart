import 'package:flutter/material.dart';

class StatusTab extends StatelessWidget {
  final double? width;
  const StatusTab({super.key, this.width});

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
