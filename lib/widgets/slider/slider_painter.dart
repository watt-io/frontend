import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SliderHandler extends StatelessWidget {
  const SliderHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      // decoration: BoxDecoration(
      //     color: Colors.white,
      //     shape: BoxShape.circle,
      //     border: Border.all(color: AppColors.textPrimary, width: 5.0),
      //     boxShadow: [
      //       BoxShadow(
      //           color: Colors.black,
      //           blurRadius: 30.0,
      //           blurStyle: BlurStyle.inner)
      //     ]),
//
      child: SvgPicture.asset(
        'assets/images/light_image.svg',
        color: Colors.amber,
        fit: BoxFit.contain,
      ),
    );
  }
}
