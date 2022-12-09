import 'package:flutter/material.dart';

@immutable
class AppUserEntity {
  final String id;
  final String displayName;

  //
  final List<AppUserServer> servers;

  const AppUserEntity({
    required this.id,
    required this.displayName,
    this.servers = const [],
  });

  factory AppUserEntity.fromMap(Map map) => AppUserEntity(
        id: map['id'],
        displayName: map['displayName'],
        servers: map["servers"] == null || map["servers"] == []
            ? []
            : (map["servers"] as List<dynamic>)
                .map((e) => AppUserServer.fromMap(e))
                .toList(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'displayName': displayName,
        "servers": servers.map((e) => e.toMap()).toList(),
      };

  AppUserEntity copyWith({String? displayName, List<AppUserServer>? servers}) =>
      AppUserEntity(
          id: id,
          displayName: displayName ?? this.displayName,
          servers: servers ?? this.servers);

  AppUserEntity addNewServer(AppUserServer server) {
    servers.add(server);
    return copyWith(servers: servers);
  }
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
