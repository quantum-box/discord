import 'package:cloud_firestore/cloud_firestore.dart';
import 'entity.dart';

class MessageDatasource {
  final CollectionReference collection;

  MessageDatasource(String serverId, String channelId)
      : collection = FirebaseFirestore.instance
            .collection('servers/$serverId/channels/$channelId/messages');

  Stream<List<MessageEntity>> streamList() =>
      collection.orderBy('sortNo').snapshots().map((e) =>
          e.docs.map((ev) => MessageEntity.fromMap(ev.data() as Map)).toList());

  Future<void> upsert(MessageEntity entity) =>
      collection.doc(entity.id).set(Map<String, dynamic>.from(entity.toMap()));
}
