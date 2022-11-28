import 'package:cloud_firestore/cloud_firestore.dart';

import './entity.dart';

class TweetDatasource {
  CollectionReference collection;

  TweetDatasource(String userId)
      : collection =
            FirebaseFirestore.instance.collection("appusers/$userId/tweets");

  CollectionReference get col => collection;

  Future<void> add(TweetEntity entity) =>
      collection.add(Map<String, dynamic>.from(entity.toMap()));

  Stream<List<TweetEntity>> streamList() =>
      collection.snapshots().map((event) =>
          event.docs.map((e) => TweetEntity.fromMap(e.data() as Map)).toList()
            ..sort(((a, b) => a.sortNo!.compareTo(b.sortNo))));
}
