import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HoverBuilder extends HookWidget {
  const HoverBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context, bool hover) builder;

  @override
  Widget build(BuildContext context) {
    final hover = useState(false);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => hover.value = true,
      onExit: (_) => hover.value = false,
      child: Builder(
        builder: (context) => builder(context, hover.value),
      ),
    );
  }
}
