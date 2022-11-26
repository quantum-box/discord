import 'package:discord_clone/appuser/entity.dart';
import 'package:state_notifier/state_notifier.dart';

class AppUserState extends StateNotifier<AppUser?> {
  AppUserState() : super(null);

  signIn(String id) => state = AppUser(id: id);
  signOut() => state = null;
}
