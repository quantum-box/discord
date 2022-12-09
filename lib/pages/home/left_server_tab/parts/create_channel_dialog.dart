import 'package:discord_clone/models/channel/entity.dart';
import 'package:discord_clone/models/server/datasource.dart';
import 'package:discord_clone/models/server/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CreateChannelDialog extends HookWidget {
  const CreateChannelDialog({
    Key? key,
    required this.serverData,
  }) : super(key: key);

  final ServerEntity serverData;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return SimpleDialog(
      children: [
        TextFormField(
          controller: controller,
        ),
        ElevatedButton(
            onPressed: () {
              if (controller.text.isEmpty) return;
              ServerDatasource(serverData.id).upsert(ServerEntity(
                  id: serverData.id,
                  name: serverData.name,
                  channels: [
                    ...serverData.channels,
                    ChannelEntity(
                        id: ChannelEntity.generateId(), name: controller.text)
                  ]));
              Navigator.pop(context);
            },
            child: Text("Create channel"))
      ],
    );
  }
}
