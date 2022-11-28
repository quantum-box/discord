class TweetEntity {
  final String id;
  final int sortNo;

  final String userId; //owner
  final String displayName;
  final String text;
  // final List<String> goodUsers;

  int get sort => sortNo ?? 0;
  const TweetEntity({
    required this.id,
    required this.userId,
    required this.displayName,
    required this.text,
    required this.sortNo,
  });
  factory TweetEntity.fromMap(Map map) => TweetEntity(
        id: map['id'],
        userId: map["userId"],
        displayName: map["displayName"] ?? "",
        text: map["text"],
        sortNo: map["sortNo"] ?? DateTime.now().microsecondsSinceEpoch,
      );
  Map toMap() => {
        "id": id,
        "userId": userId,
        "displayName": displayName,
        "text": text,
        "sortNo": sortNo,
      };
}

class TweetType {
  final String type;
  final String? lang; // プログラミング言語
  final String text;
  final int sortNo;

  const TweetType(
      {required this.type,
      this.lang,
      required this.text,
      required this.sortNo});
  factory TweetType.froMap(Map map) => TweetType(
      type: map["type"],
      lang: map["lang"],
      text: map["text"],
      sortNo: map["sortNo"]);

  Map toMap() => {
        "type": type,
        "lang": lang,
        "text": text,
        "sortNo": sortNo,
      };
}
