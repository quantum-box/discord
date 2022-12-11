import '../entity.dart';

class SummaryEntity implements EntityBase {
  @override
  final String id;
  @override
  final int sortNo;
  final SummaryMessageEntity message;

  const SummaryEntity({
    required this.id,
    required this.sortNo,
    required this.message,
  });

  factory SummaryEntity.fromMap(Map map) => SummaryEntity(
        id: map["id"],
        sortNo: map["sortNo"],
        message: SummaryMessageEntity.fromMap(map["message"]),
      );

  @override
  Map toMap() => {
        "id": id,
        "sortNo": sortNo,
        "message": message.toMap(),
      };
}

class SummaryMessageEntity implements EntityBase {
  @override
  final String id;
  @override
  final int sortNo;
  final String text;

  final String ownerId;
  final String ownerImageUrl;
  final String ownerDisplayName;

  SummaryMessageEntity({
    required this.id,
    required this.sortNo,
    required this.text,
    required this.ownerId,
    required this.ownerImageUrl,
    required this.ownerDisplayName,
  });

  factory SummaryMessageEntity.fromMap(Map map) => SummaryMessageEntity(
      id: map["id"],
      sortNo: map["sortNo"],
      text: map["text"],
      ownerId: map["ownerId"],
      ownerImageUrl: map["ownerImageUrl"],
      ownerDisplayName: map["ownerDisplayName"]);

  @override
  Map toMap() => {
        "id": id,
        "sortNo": sortNo,
        "text": text,
        "ownerId": ownerId,
        "ownerImageUrl": ownerImageUrl,
        "ownerDisplayName": ownerDisplayName,
      };
}
