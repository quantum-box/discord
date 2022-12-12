import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discord_clone/models/datasource.dart';
import 'entity.dart';

class SummaryDatasource implements DataSource<SummaryEntity> {
  final CollectionReference collection;

  SummaryDatasource(String serverId, String channelId)
      : collection = FirebaseFirestore.instance
            .collection('servers/$serverId/channels/$channelId/summaries');

  @override
  Stream<List<SummaryEntity>> streamList() =>
      collection.orderBy('sortNo', descending: true).snapshots().map((e) =>
          e.docs.map((ev) => SummaryEntity.fromMap(ev.data() as Map)).toList());

  @override
  Future<void> upsert(SummaryEntity entity) =>
      collection.doc(entity.id).set(Map<String, dynamic>.from(entity.toMap()));

  @override
  Future<void> delete(String id) => collection.doc(id).delete();

  @override
  Future<SummaryEntity> fetchObject(String id) async =>
      SummaryEntity.fromMap((await collection.doc(id).get()).data() as Map);
}
