import 'package:flutter/material.dart';

class HomeState extends ChangeNotifier {
  String currentServer;
  String currentChannel;
  HomeState({
    required this.currentServer,
    required this.currentChannel,
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
