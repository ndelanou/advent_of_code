import 'dart:developer';

import 'package:collection/collection.dart';
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
          data: (leaderboard) {
            // ignore: unnecessary_cast
            final sortedMembers = leaderboard.members.sortedBy((m) => -m.localScore as num);

            return SingleChildScrollView(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Table(
                    columnWidths: const {
                      0: IntrinsicColumnWidth(),
                      1: IntrinsicColumnWidth(),
                      2: IntrinsicColumnWidth(),
                    },
                    border: TableBorder.all(),
                    children: sortedMembers.mapIndexed((index, member) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Center(child: Text('${index + 1}')),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(member.name),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Center(child: Text('${member.localScore}')),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            log('Error loading data', error: error, stackTrace: stackTrace);

            return Center(
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Error', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.refresh(leaderboardDataProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
    );
  }
}
