import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final int breakpoint;
  final Widget pc;
  final Widget sp;
  const Responsive({
    Key? key,
    this.breakpoint = 560,
    required this.pc,
    required this.sp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > 560 ? pc : sp;
  }
}
