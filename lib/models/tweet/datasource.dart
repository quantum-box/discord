import 'package:cloud_firestore/cloud_firestore.dart';

import './entity.dart';

class TweetDatasource {
  CollectionReference collection;

  TweetDatasource(String userId)
      : collection =
            FirebaseFirestore.instance.collection("appusers/$userId/tweets");

  CollectionReference get col => collection;

  Future<void> add(TweetEntity entity) =>
      collection.doc(entity.id).set(Map<String, dynamic>.from(entity.toMap()));

  Stream<List<TweetEntity>> streamList() =>
      collection.snapshots().map((event) =>
          event.docs.map((e) => TweetEntity.fromMap(e.data() as Map)).toList()
            ..sort(((a, b) => b.sortNo.compareTo(a.sortNo))));

  Future<List<TweetEntity>> fetchAllList(List<String> userIdList) async {
    try {
      // include-arrayが10個しかダメだからmergeする必要あり
      final tweets = await FirebaseFirestore.instance
          .collectionGroup('tweets')
          // .where('userId', whereIn: userIdList)
          .orderBy("sortNo", descending: true)
          .limit(30)
          .get();
      return tweets.docs.map((e) => TweetEntity.fromMap(e.data())).toList()
        ..sort(((a, b) => b.sortNo.compareTo(a.sortNo)));
    } catch (e) {
      print(e);
      return [];
    }
  }
}
