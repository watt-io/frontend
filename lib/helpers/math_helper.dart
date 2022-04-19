import 'dart:math';

import 'dart:ui';

class MathHelper {
  double toRadian(double degree) {
    return degree * (pi / 180);
  }

  double toAngle(Offset point, Offset center) {
    return (point - center).direction;
  }

  double normalizeAngle(double angle) {
    // 360 is the max angle before normalization
    double maxAngleRad = pi * 2;
    return (angle % maxAngleRad + maxAngleRad) % maxAngleRad;
  }

  double radianToAngle(double rad) {
    return rad * (180 / pi);
  }
}
