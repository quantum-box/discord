import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddServerIcon extends HookWidget {
  final VoidCallback onTap;
  const AddServerIcon({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hover = useState(false);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => hover.value = true,
      onExit: (_) => hover.value = false,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            color: hover.value ? Colors.grey.shade800 : Colors.black,
            width: 44,
            height: 44,
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
