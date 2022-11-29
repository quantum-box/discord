import 'package:discord_clone/models/home/state.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'global_content/timeline.dart';

class GlobalServerTab extends StatelessWidget {
  const GlobalServerTab({super.key});

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeState>();
    switch (homeState.currentChannel) {
      case 'timeline':
        return const TimelineTab();
      case 'bookmark':
        return const Center(
          child: Text('bookmark'),
        );
      case 'profile':
        return const Center(
          child: Text('profile'),
        );
      default:
        return Container();
    }
  }
}
