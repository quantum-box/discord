import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/models/home/entity.dart';
import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/models/server/entity.dart';
import 'package:discord_clone/models/server/widget.dart';
import 'package:discord_clone/pages/home/server_tab/encripted_server.dart';
import 'package:discord_clone/pages/home/server_tab/global_server_icon.dart';
import 'package:discord_clone/pages/home/server_tab/server_container.dart';
import 'package:discord_clone/pages/home/server_tab/server_icon.dart';
import 'package:discord_clone/parts/select_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class MenuTab extends HookWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeState>();
    return Row(
      children: [
        Container(
          width: 60,
          child: ListView(
            children: [
              const SizedBox(height: 8),
              ServerContainer(
                  isSelected: homeState.currentServer == "encripted",
                  child: EncriptedServerIcon(
                    onTap: () {
                      print("called");
                      context.read<HomeState>().choiceServer('encripted');
                    },
                  )),
              ServerContainer(
                  isSelected: homeState.currentServer == 'global',
                  child: GlobalServerIcon(
                    onTap: () {
                      context.read<HomeState>().choiceServer('global');
                    },
                  )),
              ...[AppUserServer(id: "id", name: "name", iconUrl: "iconUrl")]
                  .map((e) => ServerContainer(
                      isSelected: homeState.currentServer == e.id,
                      child: ServerIcon(
                        serverData: e,
                        onTap: () {
                          context.read<HomeState>().choiceServer(e.id);
                        },
                      )))
                  .toList()
            ],
          ),
        ),
        Expanded(
          child: _serverCard(homeState.currentServer),
        )
      ],
    );
  }

  Widget _serverCard(String serverId) {
    if (serverId == 'encripted') {
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
    if (serverId == 'global') {
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
                selected: true,
                onTap: () {},
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
                onTap: () {},
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
                onTap: () {},
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
    ;
    return ServerCard(
      serverData: ServerEntity(
          id: "",
          name: "transparency",
          channels: [ServerChannelEntity(id: "id", name: "general")]),
    );
  }
}
