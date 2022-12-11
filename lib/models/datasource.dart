import 'package:discord_clone/models/entity.dart';

abstract class DataSource<T extends EntityBase> {
  Stream<List<T>> streamList();
  Future<void> upsert(T entity);
  Future<void> delete(String id);
}
