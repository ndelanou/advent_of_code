import 'package:collection/collection.dart';
import 'package:tuple/tuple.dart';

import '../utils/utils.dart';

class Day18 extends GenericDay {
  Day18() : super(2022, 18);

  @override
  Set<Pos3D> parseInput() {
    final lines = input.getPerLine();
    return lines.map((l) {
      final splits = l.split(',');
      return Pos3D(int.parse(splits[0]), int.parse(splits[1]), int.parse(splits[2]));
    }).toSet();
  }

  @override
  int solvePart1() {
    final cubes = parseInput();
    int counter = 0;
    for (var cube in cubes) {
      final adj = cube.adjacent().where((a) => !cubes.contains(a));
      counter += adj.length;
    }
    return counter;
  }

  @override
  int solvePart2() {
    final cubes = parseInput();
    int maxX = cubes.map((e) => e.x).max + 1;
    int maxY = cubes.map((e) => e.y).max + 1;
    int maxZ = cubes.map((e) => e.z).max + 1;

    final water = exploreWater(Pos3D(0,0,0), {}, cubes, maxX, maxY, maxZ);

    int counter = 0;
    for (var cube in cubes) {
      final adj = cube.adjacent().where((a) => !cubes.contains(a) && water.contains(a));
      counter += adj.length;
    }
    return counter; // 2528
  }
}

Set<Pos3D> exploreWater(Pos3D pos, Iterable<Pos3D> hist, Set<Pos3D> lava, int maxX, int maxY, int maxZ) {
  final Set<Pos3D> water = {};
  Set<Pos3D> newPoses = {pos};
  while (newPoses.isNotEmpty) {
    water.addAll(newPoses);
    newPoses = newPoses
      .map((e) => e.adjacent())
      .expand((element) => element)
      .where((a) => a.x >= -1 && a.x <= maxX && a.y >= -1 && a.y <= maxY && a.z >= -1 && a.z <= maxZ).toSet()
      .where((a) => !water.contains(a) && !lava.contains(a))
      .toSet();
  }

  return water;
}

typedef Pos3D = Tuple3<int, int, int>;

extension Pos3DExtension on Pos3D {
  int get x => item1;
  int get y => item2;
  int get z => item3;

  Pos3D moved(int dx, int dy, int dz) => Pos3D(this.x + dx, this.y + dy, this.z + dz);

  Iterable<Pos3D> adjacent() {
    return <Pos3D>{
      Pos3D(x, y , z - 1),
      Pos3D(x, y, z + 1),
      Pos3D(x, y - 1, z),
      Pos3D(x, y + 1, z),
      Pos3D(x - 1, y, z),
      Pos3D(x + 1, y, z),
    };
  }
}


