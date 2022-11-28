import 'package:flutter/material.dart';

@immutable
class AppUser {
  final String id;

  final List<AppUserServer>? servers;

  const AppUser({
    required this.id,
    this.servers,
  });

  factory AppUser.fromMap(Map map) => AppUser(
        id: map['id'],
        servers: map['servers'],
      );

  Map toMap() => {
        'id': id,
        "servers":
            servers != null ? servers!.map((e) => e.toMap()).toList() : null,
      };
}

class AppUserServer {
  final String id;
  final String name;
  final String iconUrl;

  AppUserServer({
    required this.id,
    required this.name,
    required this.iconUrl,
  });

  factory AppUserServer.fromMap(Map map) =>
      AppUserServer(id: map['id'], name: map['name'], iconUrl: map['iconUrl']);

  Map toMap() => {
        'id': id,
        'name': name,
        'iconUrl': iconUrl,
      };
}
