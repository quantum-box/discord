import 'package:flutter/material.dart';

class GlobalServerIcon extends StatelessWidget {
  final GestureTapCallback onTap;
  const GlobalServerIcon({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.blue.shade900,
          width: 44,
          height: 44,
          child: Icon(
            Icons.language,
            color: Colors.blueGrey.shade200,
          ),
        ),
      ),
    );
  }
}
