import 'package:discord_clone/models/entity.dart';

class HomeEntity {
  final String id;
  final int? sortNo;

  final String currentServer;
  final String currentChannel;

  HomeEntity({
    required this.id,
    this.sortNo,
    this.currentServer = 'global',
    this.currentChannel = 'timeline',
  });

  factory HomeEntity.fromMap(Map map) => HomeEntity(
        id: map['id'],
        sortNo: map['sortNo'],
        currentServer: map['currentServer'],
        currentChannel: map['currentChannel'],
      );

  Map toMap() => {
        'id': id,
        'sortNo': sortNo ?? DateTime.now().microsecondsSinceEpoch,
        'currentServer': currentServer,
        'currentChannel': currentChannel,
      };

  HomeEntity copyWith({
    String? id,
    String? currentServer,
    String? currentChannel,
  }) =>
      HomeEntity(
        id: id ?? this.id,
        currentServer: currentServer ?? this.currentServer,
        currentChannel: currentChannel ?? this.currentChannel,
      );
}
