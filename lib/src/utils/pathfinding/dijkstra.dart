import 'package:collection/collection.dart';

typedef Connection<T> = (T from, T to, num weight);
typedef ConnectionDistance<T> = (T from, num distance);

abstract class Dijkstra {
  static (Iterable<T> path, num weightSum) findPathFromPairs<T>(List<Connection<T>> entries, {required T start, required T end}) {
    final graph = entries.groupFoldBy<T, List<ConnectionDistance<T>>>((e) => e.$1, (prev, e) => ((prev ?? [])..add((e.$2, e.$3))));
    return findPathFromGraph(graph, start: start, end: end);
  }

  static (Iterable<T> path, num weightSum) findPathFromGraph<T>(Map<T, List<ConnectionDistance<T>>> graph, {required T start, required T end}) {
    final dist = <T, num>{start: 0};
    final prev = <T, T>{};
    final queue = PriorityQueue<T>((w1, w2) => (dist[w1] ?? double.infinity).compareTo(dist[w2] ?? double.infinity))..add(start);

    while (queue.isNotEmpty) {
      var current = queue.removeFirst();
      if (current != end) {
        for (final vertex in graph[current] ?? <ConnectionDistance<T>>[]) {
          final neighbor = vertex.$1;
          final weight = vertex.$2;
          final score = dist[current]! + weight;
          if (score < (dist[neighbor] ?? double.infinity)) {
            dist[neighbor] = score;
            prev[neighbor] = current;
            queue.add(neighbor);
          }
        }
      } else {
        // Reconstruct the path in reverse.
        final path = [current];
        while (prev.keys.contains(current)) {
          current = prev[current] as T;
          path.insert(0, current);
        }
        return (path, dist[end]!);
      }
    }
    return ([], -1);
  }
}

// void test(List<String> args) {
//   final points = [
//     ('A', 'B', 1), 
//     ('B', 'C', 1), // DEAD PATH
//     ('B', 'D', 1), 
//     ('D', 'R', 1), ('R', 'B', 1), // LOOPING PATH
//     ('D', 'Y', 1), ('Y', 'Z', 1), // BEST PATH
//     ('D', 'L', 1), ('L', 'M', 1), ('M', 'N', 1), ('N', 'Y', 1), // LONGER PATH
    
//   ];
//   print(Dijkstra.findPathFromPairs(points, start: 'A', end: 'Z'));
// }