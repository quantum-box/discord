import 'package:flutter/material.dart';

class ServerContainer extends StatelessWidget {
  final bool isSelected;
  final Widget child;
  const ServerContainer({
    Key? key,
    required this.isSelected,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Container(
            width: 4,
            height: 44,
            color: isSelected ? Colors.white : Colors.transparent,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8, right: 8, top: 8),
          child: child,
        ),
      ],
    );
  }
}
