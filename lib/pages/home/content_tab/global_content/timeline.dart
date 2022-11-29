import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/models/tweet/datasource.dart';
import 'package:discord_clone/models/tweet/entity.dart';
import 'package:discord_clone/models/tweet/widget.dart';
import 'package:discord_clone/parts/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:ulid/ulid.dart';

class TimelineTab extends HookWidget {
  const TimelineTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    if (user == null) {
      return Container();
    }
    final controller = useTextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(context.watch<HomeState>().currentChannel),
              ],
            ),
          ),
        ),
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
        SizedBox(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: NTextField(
                    controller: controller,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      print("object");
                      // if (controller.text == "") {
                      //   ScaffoldMessenger.of(context)
                      //       .showSnackBar(const SnackBar(
                      //     content: Text("form required"),
                      //     backgroundColor: Colors.red,
                      //   ));
                      //   return;
                      // }
                      await TweetDatasource(user.uid).add(TweetEntity(
                          id: Ulid().toString(),
                          userId: user.uid,
                          displayName: user.displayName ?? "",
                          text: controller.text,
                          sortNo: DateTime.now().microsecondsSinceEpoch));
                      controller.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Tweet",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
