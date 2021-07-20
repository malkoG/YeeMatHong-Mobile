import 'dart:async';
import 'dart:io' show Directory;

import "package:dio/dio.dart";
import "package:gql_link/gql_link.dart";
import "package:gql_dio_link/gql_dio_link.dart";

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:flutter/material.dart';

class GQLClient {
  ValueNotifier<GraphQLClient> client;

  GQLClient(this.client);

  static Future<GQLClient> initiate() async {
    // We're using HiveStore for persistence,
    // so we need to initialize Hive.
    ValueNotifier<GraphQLClient> client;

    await initHiveForFlutter();

    Directory tempDir = await getTemporaryDirectory();
    var tempPath = tempDir.path;

    final dio = Dio();
    final cookieJar = PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(tempPath)
    );
    final url = "http://192.168.0.212:8000";
    final graphqlEndpoint = "$url/graphql";

    dio.interceptors.add(CookieManager(cookieJar));

    final Link _dioLink = DioLink(
      graphqlEndpoint,
      client: dio,
    );

    client = ValueNotifier(
      GraphQLClient(
        link: _dioLink,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(store: HiveStore()),
      ),
    );

    return GQLClient(client);
  }

  static final Future<GQLClient> instance = GQLClient.initiate();
}