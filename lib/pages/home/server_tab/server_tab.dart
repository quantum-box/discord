import 'package:discord_clone/models/appuser/datasource.dart';
import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/models/channel/entity.dart';
import 'package:discord_clone/models/home/entity.dart';
import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/models/server/datasource.dart';
import 'package:discord_clone/models/server/entity.dart';
import 'package:discord_clone/models/server/widget.dart';
import 'package:discord_clone/pages/home/server_tab/parts/add_server_icon.dart';
import 'package:discord_clone/pages/home/server_tab/parts/encripted_server.dart';
import 'package:discord_clone/pages/home/server_tab/parts/global_server_icon.dart';
import 'package:discord_clone/pages/home/server_tab/parts/server_container.dart';
import 'package:discord_clone/pages/home/server_tab/parts/server_icon.dart';
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
        ServerBar(homeState: homeState, context: context),
        Expanded(
          child: _serverCard(homeState.currentServer),
        )
      ],
    );
  }

  Widget _serverCard(String serverId) {
    final context = useContext();
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
                selected:
                    context.watch<HomeState>().currentChannel == "timeline",
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
                selected:
                    context.watch<HomeState>().currentChannel == "profile",
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
                selected:
                    context.watch<HomeState>().currentChannel == "bookmark",
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
    ;
    return ServerCard(
      serverData: ServerEntity(
          id: "",
          name: "transparency",
          channels: [ChannelEntity(id: "id", name: "general")]),
    );
  }
}

class ServerBar extends HookWidget {
  const ServerBar({
    Key? key,
    required this.homeState,
    required this.context,
  }) : super(key: key);

  final HomeState homeState;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final appuser = context.watch<AppUser?>();
    print("-----");
    print(appuser);

    return SizedBox(
      width: 60,
      child: ListView(
        children: [
          const SizedBox(height: 8),
          ServerContainer(
              isSelected: homeState.currentServer == "encripted",
              child: EncriptedServerIcon(
                onTap: () {
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
          appuser == null
              ? Container()
              : Column(
                  children: appuser.servers
                      .map(
                        (e) => ServerContainer(
                          isSelected: homeState.currentServer == e.id,
                          child: ServerIcon(
                            serverData: e,
                            onTap: () {
                              context.read<HomeState>().choiceServer(e.id);
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
          ServerContainer(
            isSelected: false,
            child: AddServerIcon(onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ServerDialog(appuser: appuser!);
                  });
            }),
          ),
        ],
      ),
    );
  }
}

class ServerDialog extends HookWidget {
  final AppUser appuser;

  const ServerDialog({super.key, required this.appuser});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return SimpleDialog(
      title: const Text("Create server"),
      contentPadding: const EdgeInsets.all(16),
      children: [
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "server name",
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (controller.text == "") return;
            final server = ServerEntity.defaultValue(controller.text);

            // appuser
            appuser.addNewServer(
                AppUserServer(id: server.id, name: server.name, iconUrl: ""));
            print(appuser.toMap());
            await ServerDatasource(server.id).upsert(server);
            await AppUserDatasource(appuser.id).upsert(appuser);
            Navigator.pop(context);
          },
          child: const Text("create server"),
        )
      ],
    );
    ;
  }
}
