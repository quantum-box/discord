import 'package:discord_clone/models/appuser/datasource.dart';
import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/models/invitation/datasource.dart';
import 'package:discord_clone/models/server/datasource.dart';
import 'package:discord_clone/models/server/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class JoinServerDialog extends HookWidget {
  static Future<void> show(
    BuildContext context,
    AppUserEntity entity,
  ) =>
      showDialog(
          context: context,
          builder: (context) => JoinServerDialog(appuser: entity));

  const JoinServerDialog({
    super.key,
    required this.appuser,
  });

  final AppUserEntity appuser;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return SimpleDialog(
      title: const Text("Join server"),
      contentPadding: const EdgeInsets.all(16),
      children: [
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Invitation url",
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            if (controller.text == "") return;

            try {
              final url = Uri.parse(controller.text);
              final inviteId = url.pathSegments[1];
              final invite =
                  await InvitataionDatasource(inviteId).fetchObject();
              final next = appuser.addNewServer(AppUserServer(
                  id: invite.serverId,
                  name: invite.serverName,
                  iconUrl: invite.serverImageUrl));
              await AppUserDatasource(appuser.id).upsert(next);

              Navigator.pop(context);
            } catch (err) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Error: $err"),
                backgroundColor: Colors.red,
              ));
            }
          },
          child: const Text("join server"),
        ),
      ],
    );
  }
}
