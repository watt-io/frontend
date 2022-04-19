import 'package:flutter/material.dart';

class ScreenHelper {
  ScreenHelper({required this.context}) {
    screenSize = MediaQuery.of(context).size;
    height = screenSize!.height;
    width = screenSize!.width;
    isWiderScreen = screenSize!.width >= 1000.0;
    isBiggerScreen = screenSize!.height <= 800.0;
  }
  BuildContext context;
  Size? screenSize;
  late bool isWiderScreen;
  late bool isBiggerScreen;
  late double height;
  late double width;
}
