import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/models/message/datasource.dart';
import 'package:discord_clone/models/message/entity.dart';
import 'package:discord_clone/pages/home/content_tab/server_content/parts/send_message_form.dart';
import 'package:discord_clone/parts/text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:ulid/ulid.dart';

class ServerContentTab extends HookWidget {
  const ServerContentTab({
    super.key,
    required this.serverId,
    required this.channelId,
  });

  final String serverId;
  final String channelId;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final streamMemo = useMemoized(
        MessageDatasource(serverId, channelId).streamList,
        [channelId, serverId]);
    final messages = useStream(streamMemo);

    return Column(
      children: [
        Expanded(
            child: messages.hasData
                ? ListView(
                    children: messages.data!
                        .map((e) => ServerMessage(data: e))
                        .toList(),
                  )
                : const Center(child: CircularProgressIndicator())),
        SendMessageForm(
          submitLabel: "submit",
          controller: controller,
          onSubmit: () async {
            if (controller.text == "") {
              return;
            }
            final text = controller.text;
            controller.clear();
            final user = context.read<AppUser>();
            MessageDatasource(serverId, channelId).upsert(
                MessageEntity.defaultValue(
                    user.id, user.displayName, '', text));
          },
        )
      ],
    );
  }
}

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
              Text(data.message),
            ],
          )
        ],
      ),
    );
  }
}
