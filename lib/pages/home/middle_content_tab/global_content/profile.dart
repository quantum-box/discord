import 'package:discord_clone/models/appuser/datasource.dart';
import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/models/tweet/datasource.dart';
import 'package:discord_clone/models/tweet/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:ulid/ulid.dart';

class Profile extends HookWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final isEdit = useState<bool>(false);
    final user = context.watch<User>();
    final appuser = context.read<AppUserEntity>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: isEdit.value ? _edit(isEdit) : _display(user, isEdit),
    );
  }

  Column _display(User user, ValueNotifier isEdit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.displayName ?? Ulid().toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        ElevatedButton(
            onPressed: () {
              isEdit.value = true;
            },
            child: const Text('Edit profile')),
        const SizedBox(height: 20),
        const Divider(color: Colors.blueGrey),
        Expanded(
          child: StreamBuilder(
            stream: TweetDatasource(user.uid).streamList(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("tweets is not found"),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: snapshot.data!
                      .map((e) => Column(children: [
                            Tweet(e),
                            Divider(
                              color: Colors.grey.shade600,
                            )
                          ]))
                      .toList(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _edit(ValueNotifier isEdit) {
    final displayName = useTextEditingController();
    final context = useContext();
    final user = context.read<User>();

    final appuser = context.read<AppUserEntity>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: displayName,
          decoration: const InputDecoration(
            label: Text('Display name'),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              await AppUserDatasource(user.uid).upsert(
                  AppUserEntity(id: user.uid, displayName: displayName.text));
              await context.read<User>().updateDisplayName(displayName.text);
              isEdit.value = false;
            },
            child: const Text('Submit'))
      ],
    );
  }
}
