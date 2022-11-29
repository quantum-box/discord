import 'package:discord_clone/layout.dart';
import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/models/home/entity.dart';
import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/pages/home/server_tab.dart';

import 'package:discord_clone/pages/home/content_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:state_notifier/state_notifier.dart';

import 'package:provider/provider.dart';

class HomePage extends HookWidget {
  static WithDependecy() => ChangeNotifierProvider(
        create: (context) => HomeState(),
        child: const HomePage(),
      );
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final appuser = context.watch<AppUser?>();
    return Layout(
      title: context.watch<HomeState>().currentChannel,
      child: const DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: TabBarView(
          children: [
            MenuTab(),
            ContentTab(),
            Center(
              child: Text("data"),
            )
          ],
        ),
      ),
    );
  }
}
