// ignore_for_file: unnecessary_cast

import 'dart:developer' as dev;
import 'dart:math';

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
            final maxDay = leaderboard.members.map((e) => e.completionDayLevel.keys.lastOrNull ?? 0).reduce(max);
            final sortedMembers = leaderboard.members.sortedBy((m) => -m.localScore as num);
            final dayMemberRank = Map.fromEntries(
              List.generate(maxDay, (index) => index + 1).map((day) {
                final sortedRanks = sortedMembers.where((m) => m.completionDayLevel[day] != null).sortedBy((m) => (m.completionDayLevel[day]?[2]?.getStarTs ?? double.infinity) as num);
                return MapEntry(day, sortedRanks);
              }),
            );

            return SingleChildScrollView(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Table(
                    columnWidths: {
                      0: const IntrinsicColumnWidth(),
                      1: const IntrinsicColumnWidth(),
                      2: const IntrinsicColumnWidth(),
                      ...Map.fromEntries(dayMemberRank.keys.map((day) => MapEntry(day + 2, const IntrinsicColumnWidth()))),
                    },
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        children: [
                          const Text('N°'),
                          const Text('Name'),
                          const Text('Score'),
                          ...dayMemberRank.keys.map((day) => Text('$day')),
                        ]
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Center(child: e),
                              ),
                            )
                            .toList(),
                      ),
                      ...sortedMembers.mapIndexed((index, member) {
                        return TableRow(
                          children: [
                            Center(child: Text('${index + 1}')),
                            Text(member.name),
                            Center(child: Text('${member.localScore}')),
                            ...dayMemberRank.keys.map((day) {
                              final index = dayMemberRank[day]!.indexWhere((m) => m.id == member.id);
                              final label = index == -1 ? '' : (index + 1).toString();
                              return Center(child: Text(label, style: (index == 0) ? const TextStyle(fontWeight: FontWeight.bold) : null));
                            })
                          ]
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Center(child: e),
                                ),
                              )
                              .toList(),
                        );
                      })
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            dev.log('Error loading data', error: error, stackTrace: stackTrace);

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
