import 'package:discord_clone/models/summary/entity.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  const Summary({
    Key? key,
    required this.entity,
    required this.onRemove,
  }) : super(key: key);

  final SummaryEntity entity;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.blue,
                  backgroundImage: entity.message.ownerImageUrl.isEmpty
                      ? null
                      : NetworkImage(entity.message.ownerImageUrl),
                  child: Text(entity.message.ownerDisplayName.substring(0, 1)),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      entity.message.ownerDisplayName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SelectableText(entity.message.text),
                  ],
                ),
              ],
            ),
            PopupMenuButton<String>(
              onSelected: (String s) {
                if (s == "remove") {
                  onRemove();
                }
              },
              itemBuilder: (BuildContext context) {
                return ["remove"].map((String s) {
                  return PopupMenuItem(
                    value: s,
                    child: Text(s),
                  );
                }).toList();
              },
            )
          ],
        ));
  }
}
