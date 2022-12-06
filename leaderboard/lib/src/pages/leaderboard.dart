import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leaderboard/src/provider/leaderboard.dart';

class LeaderboardPage extends ConsumerWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataState = ref.watch(leaderboardDataProvider);

    return Scaffold(
      body: SafeArea(
        child: dataState.when(
          data: (data) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Container(child: Text(data.toString())),
            );
          },
          error: (error, stackTrace) => Container(),
          loading: () => const Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
    );
  }
}
