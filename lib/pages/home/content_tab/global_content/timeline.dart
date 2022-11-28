import 'package:discord_clone/models/tweet/datasource.dart';
import 'package:discord_clone/models/tweet/entity.dart';
import 'package:discord_clone/models/tweet/widget.dart';
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
              return ListView(
                children: snapshot.data!
                    .map((e) => Column(children: [
                          Tweet(e),
                          Divider(
                            color: Colors.grey.shade600,
                          )
                        ]))
                    .toList(),
              );
            },
          ),
        ),
        Card(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 40, top: 16),
            child: Row(
              children: [
                Expanded(
                  child: TweetTextField(
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

class TweetTextField extends StatelessWidget {
  final TextEditingController controller;

  const TweetTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "send message",
          filled: true,
          fillColor: Colors.grey.shade700,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
