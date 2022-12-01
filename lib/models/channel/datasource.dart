import 'package:cloud_firestore/cloud_firestore.dart';

class ChannelDataSource {
  final CollectionReference collection;
  static path(String serverId) => "/servers/$serverId/channels";

  ChannelDataSource(String serverId)
      : collection = FirebaseFirestore.instance.collection(path(serverId));
}
