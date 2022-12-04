import 'package:flutter/material.dart';

import 'entity.dart';

class ServerMessage extends StatelessWidget {
  const ServerMessage({
    super.key,
    required this.data,
  });

  final MessageEntity data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
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
              SelectableText(data.message),
            ],
          )
        ],
      ),
    );
  }
}
