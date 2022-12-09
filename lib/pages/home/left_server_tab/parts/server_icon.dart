import 'package:discord_clone/models/appuser/entity.dart';
import 'package:flutter/material.dart';

class ServerIcon extends StatelessWidget {
  final AppUserServer serverData;
  final GestureTapCallback onTap;
  const ServerIcon({
    super.key,
    required this.serverData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.blue,
          width: 44,
          height: 44,
          child: Center(child: Text(serverData.name.characters.first)),
        ),
      ),
    );
  }
}
