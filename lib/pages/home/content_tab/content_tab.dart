import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/pages/home/content_tab/global_content/gobal_content.dart';
import 'package:discord_clone/pages/home/content_tab/server_content/server_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentTab extends StatelessWidget {
  const ContentTab({super.key});

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeState>();
    switch (homeState.currentServer) {
      case 'global':
        return const GlobalServerTab();
      default:
        return ServerContentTab(
          channelId: homeState.currentChannel,
          serverId: homeState.currentServer,
        );
    }
  }
}
