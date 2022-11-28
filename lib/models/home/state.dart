import 'package:discord_clone/models/home/entity.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:ulid/ulid.dart';

class HomeState extends ChangeNotifier {
  String currentServer;
  String currentChannel;
  HomeState({this.currentServer = 'global', this.currentChannel = 'timeline'});

  void choiceServer(String server) {
    currentServer = server;
    notifyListeners();
  }

  choiceChannel(String channel) {
    currentChannel = channel;
    notifyListeners();
  }
}
