import 'package:flutter/material.dart';

import 'entity.dart';

class ServerCard extends StatelessWidget {
  final ServerEntity serverData;
  const ServerCard({
    Key? key,
    required this.serverData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        await showModalBottomSheet(
            context: context,
            builder: ((context) => SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text("create channel"),
                        onTap: () {},
                      )
                    ],
                  ),
                )));
      },
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(
                  serverData.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade700),
                  child: const Text(
                    "invite",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ...serverData.channels
                    .map((e) => ChannelItem(data: e))
                    .toList(),
              ],
            )),
      ),
    );
  }
}

class ChannelItem extends StatelessWidget {
  final ServerChannelEntity data;
  const ChannelItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "# ${data.name}",
        style: TextStyle(fontSize: 18, color: Colors.grey.shade200),
      ),
    ));
  }
}
