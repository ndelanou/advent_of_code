import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leaderboard/src/pages/leaderboard.dart';
import 'package:leaderboard/src/provider/dio.dart';

class ALApp extends StatelessWidget {
  const ALApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [baseUrlProvider.overrideWithValue('https://aoc.delanou.com')],
      child: MaterialApp(
        title: 'AoC Leaderboard Extended',
        theme: ThemeData(
          colorSchemeSeed: Colors.black87,
        ),
        debugShowCheckedModeBanner: false,
        home: const LeaderboardPage(),
      ),
    );
  }
}
