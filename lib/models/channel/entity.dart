import 'package:ulid/ulid.dart';

class ChannelEntity {
  static String generateId() => "c-${Ulid().toString()}";
  final String id;
  final String name;

  ChannelEntity({
    required this.id,
    required this.name,
  });

  factory ChannelEntity.fromMap(Map map) => ChannelEntity(
        id: map["id"],
        name: map["name"],
      );

  Map toMap() => {
        "id": id,
        "name": name,
      };
}
