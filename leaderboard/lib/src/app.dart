import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leaderboard/src/pages/leaderboard.dart';

class ALApp extends StatelessWidget {
  const ALApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
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
