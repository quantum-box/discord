import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import './entity.dart';

class Tweet extends HookWidget {
  final TweetEntity entity;
  const Tweet(this.entity);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(8.0),
              //   child: Image.network(
              //     "https://firebasestorage.googleapis.com/v0/b/web3-flutter.appspot.com/o/IMG_3626.JPG?alt=media&token=8f450941-dfa9-43e0-86e0-a93d84c8bef0",
              //     width: 30,
              //     height: 30,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              const SizedBox(width: 10),
              Text(entity.displayName == "" ? "github" : entity.displayName),
            ],
          ),
          // Text(entity.text),

          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bubble_chart_outlined)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.thumb_up_sharp))
            ],
          )
        ],
      ),
    );
  }
}
