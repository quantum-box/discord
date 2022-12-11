abstract class EntityBase {
  final String id;
  final int sortNo;

  EntityBase({required this.id, required this.sortNo});

  Map toMap();
}
