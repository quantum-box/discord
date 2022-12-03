import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discord_clone/models/entity.dart';
import 'package:ulid/ulid.dart';

class MessageEntity implements EntityBase {
  @override
  final String id;
  @override
  final int sortNo;

  final String ownerId;
  final String ownerName;
  final String ownerImageUrl;

  final String message;
  final DateTime createdAt;

  MessageEntity({
    required this.id,
    required this.sortNo,
    required this.ownerId,
    required this.ownerName,
    required this.ownerImageUrl,
    required this.message,
    required this.createdAt,
  });

  static MessageEntity defaultValue(
          String ownerId, ownerName, ownerImageUrl, text) =>
      MessageEntity(
          id: 'm-${Ulid().toString()}',
          sortNo: DateTime.now().microsecondsSinceEpoch,
          ownerId: ownerId,
          ownerName: ownerName,
          ownerImageUrl: ownerImageUrl,
          message: text,
          createdAt: DateTime.now());

  factory MessageEntity.fromMap(Map map) => MessageEntity(
        id: map["id"],
        sortNo: map["sortNo"] ?? DateTime.now().microsecondsSinceEpoch,
        ownerId: map['ownerId'],
        ownerName: map['ownerName'],
        ownerImageUrl: map['ownerImageUrl'],
        message: map["message"],
        createdAt: (map["createdAt"] as Timestamp).toDate(),
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "sortNo": sortNo,
        'ownerId': ownerId,
        'ownerName': ownerName,
        'ownerImageUrl': ownerImageUrl,
        "message": message,
        "createdAt": Timestamp.fromDate(createdAt),
      };
}
