import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/models/invitation/datasource.dart';
import 'package:discord_clone/models/invitation/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:ulid/ulid.dart';

import '../channel/entity.dart';
import 'entity.dart';

class ServerCard extends HookWidget {
  final ServerEntity serverData;
  const ServerCard({
    Key? key,
    required this.serverData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        await showModalBottomSheet(
            context: context,
            builder: ((context) => SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text("create channel"),
                        onTap: () {},
                      )
                    ],
                  ),
                )));
      },
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(
                  serverData.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    // invitation
                    final invitation = InvitationEntity(
                        id: Ulid().toString(),
                        sortNo: DateTime.now().microsecondsSinceEpoch,
                        serverName: serverData.name,
                        serverId: serverData.id,
                        serverImageUrl: '');
                    await InvitataionDatasource(invitation.id)
                        .upsert(invitation);
                    showDialog(
                        context: context,
                        builder: ((context) => SimpleDialog(
                              contentPadding: const EdgeInsets.all(16),
                              children: [
                                Text("invitation"),
                                SelectableText(
                                    'https://nextsns-39cd7.web.app/#/invite/${invitation.id}'),
                                IconButton(
                                    onPressed: () async {
                                      await Clipboard.setData(ClipboardData(
                                          text:
                                              'https://nextsns-39cd7.web.app/#/invite/${invitation.id}'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Copy"),
                                        backgroundColor: Colors.blue,
                                      ));
                                    },
                                    icon: const Icon(Icons.copy)),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('close'))
                              ],
                            )));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade700),
                  child: const Text(
                    "invite",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                ...serverData.channels
                    .map((e) => ChannelItem(
                          onPress: () async {
                            final vm = context.read<HomeState>();
                            vm.choiceChannel(e.id);
                          },
                          data: e,
                          selected:
                              context.watch<HomeState>().currentChannel == e.id,
                        ))
                    .toList(),
              ],
            )),
      ),
    );
  }
}

class ChannelItem extends StatelessWidget {
  const ChannelItem({
    super.key,
    required this.data,
    required this.selected,
    required this.onPress,
  });

  final ChannelEntity data;
  final bool selected;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: selected ? Colors.blueGrey.shade700 : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "# ${data.name}",
              style: TextStyle(
                fontSize: 18,
                color: selected ? Colors.white : Colors.blueGrey.shade300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
