import 'package:discord_clone/models/appuser/entity.dart';
import 'package:state_notifier/state_notifier.dart';

class AppUserState extends StateNotifier<AppUserEntity?> {
  AppUserState() : super(null);

  signIn(String id, String displayName) =>
      state = AppUserEntity(id: id, displayName: displayName);
  signOut() => state = null;
}
