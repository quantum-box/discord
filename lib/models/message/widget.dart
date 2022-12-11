import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'entity.dart';

class ServerMessage extends HookWidget {
  const ServerMessage({
    super.key,
    required this.data,
    this.onSummarized,
    this.onUnsummarized,
    this.summarized,
  }) : assert(summarized != null && onSummarized != null,
            "summarized and onSummarized must be set together");

  final MessageEntity data;
  final VoidCallback? onSummarized;
  final VoidCallback? onUnsummarized;
  final bool? summarized;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        data.ownerName,
                        style: TextStyle(color: Colors.blue.shade700),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        data.createdAt.toString(),
                        style: TextStyle(color: Colors.grey.shade600),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.message,
                    softWrap: false,
                    overflow: TextOverflow.clip,
                    style: TextStyle(),
                  ),
                ],
              )
            ],
          ),
          summarized == null
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    if (summarized!) {
                      onUnsummarized!();
                    } else {
                      onSummarized!();
                    }
                  },
                  icon: const Icon(Icons.bookmark_border),
                ),
        ],
      ),
    );
  }
}
