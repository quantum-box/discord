abstract class EntityBase {
  final String id;
  final String path;
  final int sortNo;

  EntityBase({required this.id, required this.path, required this.sortNo});
  Map toMap();
}
