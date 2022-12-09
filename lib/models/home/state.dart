import 'package:flutter/material.dart';

class HomeState extends ChangeNotifier {
  String currentServer;
  String currentChannel;
  HomeState({
    this.currentServer = 'global',
    // this.currentServer = 's-0003cd5r36dk113xkbqs03ycmn',
    this.currentChannel = 'timeline',
    // this.currentChannel = 'c-0003cd5r37my3mtv09yjpagwvd',
  });

  void choiceCurrentServer(String server) {
    currentServer = server;
    currentChannel = "home";
    notifyListeners();
  }

  choiceChannel(String channel) {
    currentChannel = channel;
    notifyListeners();
  }
}
