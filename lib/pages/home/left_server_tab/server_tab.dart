import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/models/server/datasource.dart';
import 'package:discord_clone/pages/home/left_server_tab/parts/server_card.dart';
import 'package:discord_clone/pages/home/parts/switch.dart';

import 'package:discord_clone/pages/home/left_server_tab/parts/server_bar.dart';
import 'package:discord_clone/parts/loading.dart';

import 'package:discord_clone/parts/select_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class LeftServerTab extends HookWidget {
  const LeftServerTab({
    super.key,
    required this.onChangeServer,
  });

  final void Function(String currentServer) onChangeServer;

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeState>();
    return Row(
      children: [
        ServerBar(
          homeState: homeState,
          context: context,
          onChange: onChangeServer,
        ),
        Expanded(
          child: SwitchServer(
            serverId: homeState.currentServer,
            encriptedChild: encriptedLeftCard(),
            globalChild: globalLeftCard(),
            serverChild: communityLeftCard(homeState),
          ),
        )
      ],
    );
  }

  Widget communityLeftCard(HomeState homeState) {
    return LoadingStream(
      builder: (context, data) => ServerCard(serverData: data),
      stream: ServerDatasource(homeState.currentServer).steamObject,
      keys: [homeState.currentServer],
      customLoading: const Card(
          child: Center(
        child: CircularProgressIndicator(),
      )),
    );
  }

  Widget encriptedLeftCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Encripted DM",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey.shade100,
                ),
              ),
            ),
            Divider(color: Colors.blueGrey.shade200)
          ],
        ),
      ),
    );
  }

  Widget globalLeftCard() {
    final context = useContext();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Global Twitter",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey.shade100,
                ),
              ),
            ),
            Divider(color: Colors.blueGrey.shade200),
            SelectBox(
              selected: context.watch<HomeState>().currentChannel == "timeline",
              onTap: () {
                context.read<HomeState>().choiceChannel("timeline");
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Icon(Icons.timeline_sharp),
                    SizedBox(width: 8),
                    Text(
                      "Timeline",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SelectBox(
              selected: context.watch<HomeState>().currentChannel == "profile",
              onTap: () {
                context.read<HomeState>().choiceChannel("profile");
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Icon(Icons.account_circle_outlined),
                    SizedBox(width: 8),
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SelectBox(
              selected: context.watch<HomeState>().currentChannel == "bookmark",
              onTap: () {
                context.read<HomeState>().choiceChannel("bookmark");
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Icon(Icons.bookmark_border),
                    SizedBox(width: 8),
                    Text(
                      "Bookmarks",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
