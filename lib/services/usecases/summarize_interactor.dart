import 'package:discord_clone/models/datasource.dart';
import 'package:discord_clone/models/message/entity.dart';
import 'package:discord_clone/models/summary/entity.dart';
import 'package:ulid/ulid.dart';

class SummerizeInteractor {
  final DataSource<SummaryEntity> _summaryRepo;
  final DataSource<MessageEntity> _messageRepo;

  SummerizeInteractor(this._summaryRepo, this._messageRepo);

  Future<void> pin(MessageEntity message) async {
    final summary = SummaryEntity(
        id: Ulid().toString(),
        sortNo: DateTime.now().microsecondsSinceEpoch,
        message: SummaryMessageEntity(
            id: message.id,
            sortNo: message.sortNo,
            text: message.message,
            ownerId: message.ownerId,
            ownerImageUrl: message.ownerImageUrl,
            ownerDisplayName: message.ownerName));
    message.summarized(summary.id);

    await _summaryRepo.upsert(summary);
    await _messageRepo.upsert(message);
  }

  Future<void> unpin(String summeryId) async {
    await _summaryRepo.delete(summeryId);
  }
}
