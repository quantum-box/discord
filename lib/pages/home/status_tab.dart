import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/pages/home/parts/switch.dart';
import 'package:discord_clone/pages/home/right_view/server_stock_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusTab extends StatelessWidget {
  const StatusTab({super.key, this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeState>();
    return SizedBox(
      width: width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SwitchServer(
            globalChild: Center(
              child: Text('global'),
            ),
            serverChild: const ServerRightCard(),
            serverId: homeState.currentServer,
            encriptedChild: Column(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Text('status'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
