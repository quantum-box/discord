import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/pages/home/server_tab/parts/server_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'add_server_icon.dart';
import 'create_server_dialog.dart';
import 'encripted_server.dart';
import 'global_server_icon.dart';
import 'server_icon.dart';

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
                  context.read<HomeState>().choiceChannel('timeline');
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
            child: AddServerIcon(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CreateServerDialog(appuser: appuser!);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
