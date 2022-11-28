import 'package:flutter/material.dart';

class SelectBox extends StatelessWidget {
  final GestureTapCallback onTap;
  final Widget child;
  final bool selected;
  final double? width;
  final double? height;
  final double borderRadiusNumber;

  const SelectBox({
    Key? key,
    required this.child,
    required this.onTap,
    this.selected = false,
    this.width,
    this.height,
    this.borderRadiusNumber = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadiusNumber),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadiusNumber),
        onTap: () {},
        child: Container(
          width: width,
          height: height,
          color: selected ? Colors.blueGrey.shade700 : Colors.transparent,
          child: child,
        ),
      ),
    );
  }
}
