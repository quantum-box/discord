import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/models/message/datasource.dart';
import 'package:discord_clone/models/message/entity.dart';
import 'package:discord_clone/models/message/widget.dart';
import 'package:discord_clone/pages/home/content_tab/server_content/parts/send_message_form.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

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
                        .map((e) => ServerMessage(
                              data: e,
                              onSammarized: () {},
                            ))
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
