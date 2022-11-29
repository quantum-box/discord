import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/pages/home/content_tab/global_content/profile.dart';
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
        if (MediaQuery.of(context).size.width > 560) {
          return const TimelineTab();
        }
        return const SafeArea(child: TimelineTab());
      case 'bookmark':
        return const Center(
          child: Text('bookmark'),
        );
      case 'profile':
        return const Profile();
      default:
        return Container();
    }
  }
}
