import 'package:discord_clone/layout.dart';
import 'package:discord_clone/models/tweet/entity.dart';
import 'package:discord_clone/models/tweet/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class TimelinePage extends HookWidget {
  const TimelinePage({super.key});
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    final controller = useTextEditingController();
    return Layout(
      title: "discord clone",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: ListView(
            children: [
              TweetEntity(
                  id: "id",
                  userId: user!.uid,
                  displayName: user.displayName ?? "",
                  text: "",
                  sortNo: DateTime.now().microsecondsSinceEpoch)
            ].map((e) => Tweet(e)).toList(),
          )),
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '1',
            style: Theme.of(context).textTheme.headline4,
          ),
          Card(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 40, top: 16),
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
                        onPressed: () {},
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
                )),
          )
        ],
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class TweetTextField extends StatelessWidget {
  final TextEditingController controller;

  const TweetTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
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
