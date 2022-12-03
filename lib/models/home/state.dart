import 'package:discord_clone/models/home/entity.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:ulid/ulid.dart';

class HomeState extends ChangeNotifier {
  String currentServer;
  String currentChannel;
  HomeState({
    // this.currentServer = 'global',
    this.currentServer = 's-0003cd5r36dk113xkbqs03ycmn',
    // this.currentChannel = 'timeline',
    this.currentChannel = 'c-0003cd5r37my3mtv09yjpagwvd',
  });

  void choiceServer(String server) {
    currentServer = server;
    notifyListeners();
  }

  choiceChannel(String channel) {
    currentChannel = channel;
    notifyListeners();
  }
}
