import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import './entity.dart';

class Tweet extends HookWidget {
  final TweetEntity entity;
  const Tweet(this.entity);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.blueGrey.shade600,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entity.displayName == "" ? "github" : entity.displayName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(entity.text),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          bottomIcons()
        ],
      ),
    );
  }

  Row bottomIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.format_quote)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.bubble_chart_outlined)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up_sharp)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.share))
      ],
    );
  }
}
