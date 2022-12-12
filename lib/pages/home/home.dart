import 'package:discord_clone/constants/theme.dart';
import 'package:discord_clone/models/appuser/datasource.dart';
import 'package:discord_clone/models/tweet/entity.dart';
import 'package:discord_clone/pages/home/parts/switch.dart';
import 'package:discord_clone/pages/home/status_tab.dart';
import 'package:discord_clone/parts/layout.dart';
import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/models/tweet/datasource.dart';
import 'package:discord_clone/pages/home/left_server_tab/server_tab.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

import 'middle_content_tab/global_content/gobal_content.dart';
import 'middle_content_tab/community_server_content/community_server_content.dart';

class HomePage extends HookWidget {
  static Widget withDependecy(String uid, serverId, channelId) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) =>
                  HomeState(currentServer: serverId, currentChannel: channelId),
              child: const HomePage()),
          StreamProvider<AppUserEntity?>(
              create: ((context) => AppUserDatasource(uid).streamObject()),
              initialData: null),
          StreamProvider<List<TweetEntity>>(
              create: ((context) => TweetDatasource(uid).streamList()),
              initialData: const []),
        ],
        child: const HomePage(),
      );
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Layout(
      title: context.watch<HomeState>().currentChannel,
      child: width > kBreakpoint
          ? Row(
              children: [
                SizedBox(
                    width: 300,
                    child: LeftServerTab(onChangeServer: (currentServer) {
                      context.go("/$currentServer/home");
                      context
                          .read<HomeState>()
                          .choiceCurrentServer(currentServer);
                    })),
                Expanded(child: _middleContentTab()),
                SizedBox(width: 600, child: _rightTabp())
              ],
            )
          : DefaultTabController(
              initialIndex: 1,
              length: 3,
              child: TabBarView(
                children: [
                  LeftServerTab(
                      onChangeServer:
                          context.read<HomeState>().choiceCurrentServer),
                  _middleContentTab(),
                  _rightTabp(),
                ],
              ),
            ),
    );
  }

  Widget _middleContentTab() {
    final context = useContext();
    final homeState = context.watch<HomeState>();
    return SwitchServer(
        serverId: homeState.currentServer,
        encriptedChild: Container(),
        globalChild: const GlobalServerTab(),
        serverChild: ServerContentTab(
          channelId: homeState.currentChannel,
          serverId: homeState.currentServer,
        ));
  }

  Widget _rightTabp() {
    final context = useContext();
    final homeState = context.watch<HomeState>();
    return SwitchServer(
        serverId: homeState.currentServer,
        encriptedChild: const StatusTab(),
        globalChild: const StatusTab(),
        serverChild: const StatusTab());
  }
}
