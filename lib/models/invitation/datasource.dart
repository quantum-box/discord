import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discord_clone/models/invitation/entity.dart';

class InvitataionDatasource {
  final DocumentReference doc;

  InvitataionDatasource(String id)
      : doc = FirebaseFirestore.instance.collection('invitations').doc(id);

  Future<InvitationEntity> fetchObject() =>
      doc.get().then((value) => InvitationEntity.fromMap(value.data() as Map));

  Future<void> upsert(InvitationEntity entity) => doc.set(entity.toMap());
}
