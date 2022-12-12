import 'package:cloud_firestore/cloud_firestore.dart';
import '../datasource.dart';
import 'entity.dart';

class MessageDatasource implements DataSource<MessageEntity> {
  final CollectionReference collection;

  MessageDatasource(String serverId, String channelId)
      : collection = FirebaseFirestore.instance
            .collection('servers/$serverId/channels/$channelId/messages');

  @override
  Stream<List<MessageEntity>> streamList() =>
      collection.orderBy('sortNo', descending: true).snapshots().map((e) =>
          e.docs.map((ev) => MessageEntity.fromMap(ev.data() as Map)).toList());

  @override
  Future<void> upsert(MessageEntity entity) =>
      collection.doc(entity.id).set(Map<String, dynamic>.from(entity.toMap()));

  @override
  Future<void> delete(String id) => collection.doc(id).delete();

  @override
  Future<MessageEntity> fetchObject(String id) async =>
      MessageEntity.fromMap((await collection.doc(id).get()).data() as Map);
}
