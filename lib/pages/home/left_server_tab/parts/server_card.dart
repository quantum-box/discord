import 'package:discord_clone/models/channel/entity.dart';
import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/models/invitation/datasource.dart';
import 'package:discord_clone/models/invitation/entity.dart';
import 'package:discord_clone/models/server/datasource.dart';
import 'package:discord_clone/models/server/entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ulid/ulid.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'create_channel_dialog.dart';
import 'invite_button.dart';

class ServerCard extends HookWidget {
  final ServerEntity serverData;
  const ServerCard({
    Key? key,
    required this.serverData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return CreateChannelDialog(
                serverData: serverData,
              );
            });
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
                InviteButton(serverData: serverData),
                const SizedBox(height: 16),
                ChannelItem(
                    data: ChannelEntity(id: "home", name: "home"),
                    selected:
                        context.watch<HomeState>().currentChannel == "home",
                    onPress: () {
                      final vm = context.read<HomeState>();
                      context.go("/${vm.currentServer}/home");
                      vm.choiceChannel("home");
                    }),
                ...serverData.channels
                    .map((e) => ChannelItem(
                          onPress: () async {
                            final vm = context.read<HomeState>();
                            context.go("/${vm.currentServer}/${e.id}");
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

// class ModalInsideModal extends StatelessWidget {
//   final bool reverse;

//   const ModalInsideModal({Key? key, this.reverse = false}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         child: SafeArea(
//             child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [Text("create channel")],
//       ),
//     )));
//   }
// }
