import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discord_clone/models/appuser/entity.dart';

class AppUserDatasource {
  final String userId;

  AppUserDatasource(this.userId);

  Stream<AppUserEntity> streamObject() => FirebaseFirestore.instance
      .collection('appusers')
      .doc(userId)
      .snapshots()
      .map((e) => AppUserEntity.fromMap(e.data() as Map));

  Future<AppUserEntity> fetchObject() =>
      FirebaseFirestore.instance.collection('appusers').doc(userId).get().then(
            (value) => AppUserEntity.fromMap(value.data() as Map),
          );
  Future<void> upsert(AppUserEntity entity) => FirebaseFirestore.instance
      .collection('appusers')
      .doc(userId)
      .set(entity.toMap());
}
