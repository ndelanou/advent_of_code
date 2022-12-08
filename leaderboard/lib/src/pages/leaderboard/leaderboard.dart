// ignore_for_file: unnecessary_cast

import 'dart:developer' as dev;
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leaderboard/src/provider/leaderboard.dart';

import 'widgets/error.dart';

class LeaderboardPage extends ConsumerWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(leaderboardDataProvider, (previous, next) {
      if (next.hasError) {
        final errorState = next.asError!;
        dev.log('Error loading data', error: errorState.error, stackTrace: errorState.stackTrace);
      }
    });
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  sortColumnIndex: 4,
                  columns: [
                    const Text('N°'),
                    const Text('Name'),
                    const Text('Score'),
                    ...dayMemberRank.keys.map((day) => Text('$day')),
                  ]
                      .map(
                        (e) => DataColumn(
                          label: e,
                        ),
                      )
                      .toList(),
                  rows: sortedMembers.mapIndexed((index, member) {
                    return DataRow(
                      cells: [
                        Text((index + 1).toString()),
                        Text(member.name),
                        Text(member.localScore.toString()),
                        ...dayMemberRank.keys.map((day) {
                          final index = dayMemberRank[day]!.indexWhere((m) => m.id == member.id);
                          final label = index == -1 ? '' : (index + 1).toString();
                          return Center(child: Text(label, style: (index == 0) ? const TextStyle(fontWeight: FontWeight.bold) : null));
                        })
                      ]
                          .map(
                            DataCell.new,
                          )
                          .toList(),
                    );
                  }).toList(),
                ),
              ),
            );
          },
          error: (error, stackTrace) => Center(
            child: ALErrorWidget(
              error,
              stackTrace: stackTrace,
              onRetry: () => ref.refresh(leaderboardDataProvider),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
    );
  }
}
