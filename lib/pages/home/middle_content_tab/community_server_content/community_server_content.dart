import 'package:discord_clone/models/appuser/entity.dart';
import 'package:discord_clone/models/message/datasource.dart';
import 'package:discord_clone/models/message/entity.dart';
import 'package:discord_clone/models/message/widget.dart';
import 'package:discord_clone/pages/home/middle_content_tab/community_server_content/parts/send_message_form.dart';
import 'package:discord_clone/parts/loading.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'parts/home_channel.dart';

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

    if (channelId == "home") {
      return const HomeChannel();
    }

    return Column(
      children: [
        messages(),
        SendMessageForm(
          submitLabel: "submit",
          controller: controller,
          onSubmit: () async {
            if (controller.text == "") return;
            final text = controller.text;
            controller.clear();
            final user = context.read<AppUserEntity>();
            MessageDatasource(serverId, channelId).upsert(
                MessageEntity.defaultValue(
                    user.id, user.displayName, '', text));
          },
        )
      ],
    );
  }

  Widget messages() {
    return Expanded(
      child: LoadingStream(
        builder: (context, data) => SelectionArea(
          child: ListView(
              reverse: true,
              children: data
                  .map((e) => ServerMessage(
                        data: e,
                        onSammarized: () {},
                      ))
                  .toList()),
        ),
        stream: MessageDatasource(serverId, channelId).streamList,
        keys: [serverId, channelId],
      ),
    );
  }
}
