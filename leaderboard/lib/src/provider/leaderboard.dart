import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:leaderboard/src/core/types.dart';
import 'package:leaderboard/src/domain/leaderboard.entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'leaderboard.g.dart';

@riverpod
Future<Leaderboard> leaderboardData(LeaderboardDataRef ref) async {
  return Leaderboard.fromJson(await _readJson());
}

Future<JsonObject> _readJson() async {
  final response = await rootBundle.loadString('assets/leaderboard_data.json');
  final data = await json.decode(response);
  return data as JsonObject;
}
