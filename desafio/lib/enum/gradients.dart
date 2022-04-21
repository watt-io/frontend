import 'package:flutter/painting.dart';

enum Gradients { green, blue }

extension GradientsExtension on Gradients {
  Gradient get gradient {
    switch (this) {
      case Gradients.green:
        return const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
          stops: [0.2, 1],
          colors: [
            Color(0xff1bc147),
            Color(0xff95f486),
            // Color(0xf068e953),
          ],
        );

      case Gradients.blue:
        return const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
          stops: [0.2, 1],
          colors: [
            Color(0xff1A61C1),
            Color(0xff6BD7F5),
          ],
        );

      default:
        throw 'Gradients not found';
    }
  }

  Color get color {
    switch (this) {
      case Gradients.green:
        return const Color(0xff1bc147);

      case Gradients.blue:
        return const Color(0xff1A61C1);

      default:
        throw 'Gradients not found';
    }
  }
}
