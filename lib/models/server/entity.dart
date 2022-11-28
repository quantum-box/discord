class ServerEntity {
  final String id;
  final String name;
  final List<ServerChannelEntity> channels;

  ServerEntity({
    required this.id,
    required this.name,
    required this.channels,
  });
}

class ServerChannelEntity {
  final String id;
  final String name;

  ServerChannelEntity({required this.id, required this.name});
}
