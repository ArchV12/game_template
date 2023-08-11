import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';

class Utils {
  // This is a fixed random seed.  This means the random numbers generated
  // will be the same in the same order every time the game is run.
  // If you want truely random swap in the commented randomSeed line.

  //static int randomSeed = Random().nextInt(1 << 32);
  static int randomSeed = 25;
  static Random numberGenerator = Random(randomSeed);

  //-------------------------------------------------------------------------------------------------
  // RangeMapping
  //
  // For value in range r1s to r1e, find the equivalent resultingValue in the range r2s to r2e.
  //-------------------------------------------------------------------------------------------------
  static double rangeMapping(double value, double r1s, double r1e, double r2s, double r2e) {
    // FORMULA:
    // S = ((F-A)(D-C) / (B-A)) + C
    value = clampDouble(value, r1s, r1e);
    double result = ((value - r1s) * (r2e - r2s) / (r1e - r1s)) + r2s;

    return result;
  }

  static int rangeMappingInt(int value, int r1s, int r1e, int r2s, int r2e) {
    // FORMULA:
    // S = ((F-A)(D-C) / (B-A)) + C
    value = value.clamp(r1s, r1e);
    double result = ((value - r1s) * (r2e - r2s) / (r1e - r1s)) + r2s;

    return result.round();
  }

  // A custom RangeMapping method that takes a float in a range and maps it to two vectors
  static Vector3 rangeMappingVec3(double value, double r1s, double r1e, Vector3 r2s, Vector3 r2e) {
    double x = ((value - r1s) * (r2e.x - r2s.x) / (r1e - r1s)) + r2s.x;
    double y = ((value - r1s) * (r2e.y - r2s.y) / (r1e - r1s)) + r2s.y;
    double z = ((value - r1s) * (r2e.z - r2s.z) / (r1e - r1s)) + r2s.z;

    return Vector3(x, y, z);
  }

  // A custom RangeMapping method that takes a float in a range and maps it to two 2d vectors
  static Vector2 rangeMappingVec2(double value, double r1s, double r1e, Vector2 r2s, Vector2 r2e) {
    double x = ((value - r1s) * (r2e.x - r2s.x) / (r1e - r1s)) + r2s.x;
    double y = ((value - r1s) * (r2e.y - r2s.y) / (r1e - r1s)) + r2s.y;

    return Vector2(x, y);
  }

  // Takes a list of strings that represent a map in string format
  // Example:
  // "name: John",
  // "lastName: Doe"
  // ... and convert is into a real Map<String, String>
  static Map<String, String> dataMapFromList(List<String> dataList) {
    Map<String, String> finalMap = {};
    for (String s in dataList) {
      List<String> splitList = s.split(': ');
      if (splitList.length == 1) {
        finalMap[splitList[0]] = '';
      } else if (splitList.length == 2) {
        finalMap[splitList[0]] = splitList[1];
      } else {
        throw ('Error: splitting the string for parameters had too many!');
      }
    }
    return finalMap;
  }

  // Resets the random number generator to the start with the seed.
  static void resetRandom() {
    numberGenerator = Random(randomSeed);
  }

  // Genreates a random double from in to max inclusive
  static double randomDouble(double min, double max) {
    return numberGenerator.nextDouble() * (max - min) + min;
  }

  // Generates a random integer from min to max exclusive
  static int randomInt(int min, int max) {
    return numberGenerator.nextInt(max - min) + min;
  }

  // Generates a random Vector2 with mins and maxes
  static Vector2 randomVector2(double minX, double maxX, double minY, double maxY) {
    double x = randomDouble(minX, maxX);
    double y = randomDouble(minY, maxY);
    return Vector2(x, y);
  }
}
