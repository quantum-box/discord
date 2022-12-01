import 'package:ulid/ulid.dart';

import '../channel/entity.dart';

class ServerEntity {
  static String generateId() => "s-${Ulid().toString()}";

  final String id;
  final String name;
  final List<ChannelEntity> channels;

  ServerEntity({
    required this.id,
    required this.name,
    required this.channels,
  });

  factory ServerEntity.fromMap(Map map) => ServerEntity(
        id: map["id"],
        name: map["name"],
        channels: (map["channels"] as List<Map>)
            .map((e) => ChannelEntity.fromMap(e))
            .toList(),
      );

  factory ServerEntity.defaultValue(String name) =>
      ServerEntity(id: ServerEntity.generateId(), name: name, channels: [
        ChannelEntity(id: ChannelEntity.generateId(), name: "general"),
        ChannelEntity(id: ChannelEntity.generateId(), name: "random")
      ]);

  Map toMap() => {
        "id": id,
        "name": name,
        "channels": channels.map((e) => e.toMap()).toList(),
      };
}
