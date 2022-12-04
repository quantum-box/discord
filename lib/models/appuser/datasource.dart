import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discord_clone/models/appuser/entity.dart';

class AppUserDatasource {
  final DocumentReference collection;

  AppUserDatasource(String userId)
      : collection =
            FirebaseFirestore.instance.collection('appusers').doc(userId);

  Stream<AppUser> streamObject() =>
      collection.snapshots().map((e) => AppUser.fromMap(e.data() as Map));

  Future<AppUser> fetchObject() => collection.get().then(
        (value) => AppUser.fromMap(value.data() as Map),
      );
  Future<void> upsert(AppUser entity) => collection.set(entity.toMap());
}
