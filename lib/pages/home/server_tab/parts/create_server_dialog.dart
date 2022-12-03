import 'package:discord_clone/models/appuser/datasource.dart';
import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/models/server/datasource.dart';
import 'package:discord_clone/models/server/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CreateServerDialog extends HookWidget {
  final AppUser appuser;

  const CreateServerDialog({super.key, required this.appuser});

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
