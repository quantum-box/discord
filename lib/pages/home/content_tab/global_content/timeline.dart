import 'package:discord_clone/constants/theme.dart';
import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/models/tweet/datasource.dart';
import 'package:discord_clone/models/tweet/entity.dart';
import 'package:discord_clone/models/tweet/widget.dart';
import 'package:discord_clone/parts/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:ulid/ulid.dart';

class TimelineTab extends HookWidget {
  const TimelineTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    if (user == null) {
      return Container();
    }
    final controller = useTextEditingController();
    final tweets = useState<List<TweetEntity>>([]);

    Future<void> fetchTweets() async {
      final res = await TweetDatasource(user.uid).fetchAllList([
        'YZ02tTfPePZRO9Rk7gqiPy8QIGd2',
        'RfgRitwAiGUtpRvqzSBIplPyNEY2',
        'FJD3g10KUPh0vlA6xGeq1pA3C0Z2'
      ]);
      tweets.value = res;
    }

    useEffect(() {
      fetchTweets();
    }, []);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MediaQuery.of(context).size.width > kBreakpoint
            ? serverAppBar(context)
            : Container(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symme　tric(horizontal: 16),
            child: RefreshIndicator(
              onRefresh: fetchTweets,
              child: ListView(
                children: tweets.value
                    .map((e) => Column(children: [
                          Tweet(e),
                          Divider(
                            color: Colors.grey.shade600,
                          )
                        ]))
                    .toList(),
              ),
            ),
          ),
        ),
        SizedBox(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: NTextField(
                    controller: controller,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      print("object");
                      if (controller.text == "") {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("form required"),
                          backgroundColor: Colors.red,
                        ));
                        return;
                      }
                      await TweetDatasource(user.uid).add(TweetEntity(
                          id: Ulid().toString(),
                          userId: user.uid,
                          displayName: user.displayName ?? "",
                          text: controller.text,
                          sortNo: DateTime.now().microsecondsSinceEpoch));
                      controller.clear();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Posteds"),
                        backgroundColor: Colors.blue,
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Tweet",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  SizedBox serverAppBar(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(context.watch<HomeState>().currentChannel),
          ],
        ),
      ),
    );
  }
}
