import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discord_clone/models/server/entity.dart';

class ServerDatasource {
  final DocumentReference collection;
  static path(String serverId) => "servers/$serverId";

  ServerDatasource(String serverId)
      : collection =
            FirebaseFirestore.instance.collection("servers").doc(serverId);

  Future<void> upsert(ServerEntity entity) => collection.set(entity.toMap());

  Stream<ServerEntity> steamObject() =>
      collection.snapshots().map((e) => ServerEntity.fromMap(e.data() as Map));
}
