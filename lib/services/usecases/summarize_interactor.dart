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
    final summarisedMessage = message.summarized(summary.id);

    await _summaryRepo.upsert(summary);
    await _messageRepo.upsert(summarisedMessage);
  }

  Future<void> unpin(String summeryId) async {
    final summery = await _summaryRepo.fetchObject(summeryId);
    final message = await _messageRepo.fetchObject(summery.message.id);

    final unSummarizedMessage = message.unSummarized();

    await _summaryRepo.delete(summery.id);
    await _messageRepo.upsert(unSummarizedMessage);
  }
}
