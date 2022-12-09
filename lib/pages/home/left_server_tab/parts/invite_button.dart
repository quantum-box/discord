import 'package:discord_clone/models/invitation/datasource.dart';
import 'package:discord_clone/models/invitation/entity.dart';
import 'package:discord_clone/models/server/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ulid/ulid.dart';

class InviteButton extends HookWidget {
  const InviteButton({
    Key? key,
    required this.serverData,
  }) : super(key: key);

  final ServerEntity serverData;

  @override
  Widget build(BuildContext context) {
    final context = useContext();
    return ElevatedButton(
      onPressed: () async {
        // invitation
        final invitation = InvitationEntity(
            id: Ulid().toString(),
            sortNo: DateTime.now().microsecondsSinceEpoch,
            serverName: serverData.name,
            serverId: serverData.id,
            serverImageUrl: '');
        await InvitataionDatasource(invitation.id).upsert(invitation);
        showDialog(
            context: context,
            builder: ((context) => SimpleDialog(
                  contentPadding: const EdgeInsets.all(16),
                  children: [
                    Text("invitation"),
                    SelectableText(
                        'https://nextsns-39cd7.web.app/invite/${invitation.id}'),
                    IconButton(
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(
                              text:
                                  'https://nextsns-39cd7.web.app/invite/${invitation.id}'));
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
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade700),
      child: const Text(
        "invite",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
