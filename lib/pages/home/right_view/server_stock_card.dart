import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/models/message/datasource.dart';
import 'package:discord_clone/models/summary/datasource.dart';
import 'package:discord_clone/models/summary/widget.dart';
import 'package:discord_clone/parts/loading.dart';
import 'package:discord_clone/services/usecases/summarize_interactor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class ServerRightCard extends HookWidget {
  const ServerRightCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeState>();
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Stock information",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: LoadingStream(
                keys: [homeState.currentServer, homeState.currentChannel],
                stream: SummaryDatasource(
                        homeState.currentServer, homeState.currentChannel)
                    .streamList,
                builder: (BuildContext context, data) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final e = data[data.length - index - 1];
                      return Summary(
                          entity: e,
                          onRemove: () {
                            final vm = context.read<HomeState>();
                            SummerizeInteractor(
                                    SummaryDatasource(
                                        vm.currentServer, vm.currentChannel),
                                    MessageDatasource(
                                        vm.currentServer, vm.currentChannel))
                                .unpin(e.id);
                          });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
