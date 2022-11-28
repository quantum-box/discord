import 'package:discord_clone/models/home/state.dart';
import 'package:discord_clone/pages/home/content_tab/gobal_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ulid/ulid.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:discord_clone/models/tweet/datasource.dart';
import 'package:discord_clone/models/tweet/entity.dart';
import 'package:discord_clone/models/tweet/widget.dart';

class ContentTab extends StatelessWidget {
  const ContentTab({super.key});

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeState>();
    switch (homeState.currentServer) {
      case 'global':
        return const GlobalServerTab();
      default:
        return Container(
          child: Text('not found'),
        );
    }
  }
}
