import 'package:discord_clone/models/appuser/datasource.dart';
import 'package:discord_clone/pages/home/status_tab.dart';
import 'package:discord_clone/parts/layout.dart';
import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/models/tweet/datasource.dart';
import 'package:discord_clone/pages/home/server_tab.dart';

import 'package:discord_clone/pages/home/content_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:provider/provider.dart';

import '../models/tweet/entity.dart';

class HomePage extends HookWidget {
  static Widget withDependecy(String uid) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => HomeState(),
            child: const HomePage(),
          ),
          StreamProvider<AppUser?>(
              create: ((context) => AppUserDatasource(uid).streamObject()),
              initialData: null),
          StreamProvider<List<TweetEntity>>(
              create: ((context) =>
                  TweetDatasource(context.watch<User>().uid).streamList()),
              initialData: const [])
        ],
        child: const HomePage(),
      );
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final appuser = context.watch<AppUser?>();
    return Layout(
      title: context.watch<HomeState>().currentChannel,
      child: width > 560
          ? Row(
              children: const [
                SizedBox(width: 300, child: MenuTab()),
                Expanded(child: ContentTab()),
                StatusTab(width: 300)
              ],
            )
          : const DefaultTabController(
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
