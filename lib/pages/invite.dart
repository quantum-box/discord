import 'package:discord_clone/models/appuser/datasource.dart';
import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/models/invitation/datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class InvitePage extends HookWidget {
  const InvitePage({
    Key? key,
    this.inviteId,
  }) : super(key: key);

  final String? inviteId;

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    final user = context.read<User>();
    final invitationFuture =
        useFuture(InvitataionDatasource(inviteId!).fetchObject());

    if (inviteId == null || !invitationFuture.hasData) {
      return const Scaffold(
        body: Center(child: Text("not found")),
      );
    }

    return Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(invitationFuture.data!.serverName),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      loading.value = true;
                      final invitation = invitationFuture.data!;
                      final appuser =
                          await AppUserDatasource(user.uid).fetchObject();
                      appuser.addNewServer(AppUserServer(
                          id: invitation.serverId,
                          name: invitation.serverName,
                          iconUrl: invitation.serverImageUrl));
                      await AppUserDatasource(appuser.id).upsert(appuser);
                      loading.value = false;
                      context.go('/');
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text('Accept invitation'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
