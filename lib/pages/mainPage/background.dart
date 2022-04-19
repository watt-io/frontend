import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/background_image.svg",
      color: Colors.white.withOpacity(0.4),
      colorBlendMode: BlendMode.modulate,
    );
  }
}
