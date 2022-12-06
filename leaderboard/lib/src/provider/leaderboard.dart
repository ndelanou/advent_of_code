import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leaderboard/src/core/types.dart';
import 'package:leaderboard/src/domain/leaderboard.entity.dart';
import 'package:leaderboard/src/provider/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'leaderboard.g.dart';

@Riverpod(keepAlive: true)
Future<Leaderboard> leaderboardData(LeaderboardDataRef ref) async {
  return Leaderboard.fromJson(await _getFromWeb(ref));
}

Future<JsonObject> _getFromWeb(Ref ref) async {
  final response = await ref.watch(dioClientProvider).get('/public/leaderboard_data.json');
  return response.data as JsonObject;
}
