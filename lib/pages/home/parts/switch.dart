import 'package:flutter/material.dart';

class SwitchServer extends StatelessWidget {
  const SwitchServer({
    Key? key,
    required this.serverId,
    required this.encriptedChild,
    required this.globalChild,
    required this.serverChild,
  }) : super(key: key);

  final String serverId;
  final Widget encriptedChild;
  final Widget globalChild;
  final Widget serverChild;

  @override
  Widget build(BuildContext context) {
    switch (serverId) {
      case "encripted":
        return encriptedChild;
      case "global":
        return globalChild;
      default:
        return serverChild;
    }
  }
}
