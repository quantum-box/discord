import 'package:discord_clone/models/entity.dart';

class InvitationEntity implements EntityBase {
  @override
  final String id;
  @override
  final int sortNo;

  final String serverName;
  final String serverId;
  final String serverImageUrl;

  InvitationEntity({
    required this.id,
    required this.sortNo,
    required this.serverName,
    required this.serverId,
    required this.serverImageUrl,
  });

  factory InvitationEntity.fromMap(Map map) => InvitationEntity(
      id: map['id'],
      sortNo: map['sortNo'],
      serverName: map['serverName'],
      serverId: map['serverId'],
      serverImageUrl: map['serverImageUrl']);

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'sortNo': sortNo,
        'serverName': serverName,
        'serverId': serverId,
        'serverImageUrl': serverImageUrl,
      };
}
