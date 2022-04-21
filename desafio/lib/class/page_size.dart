import 'package:flutter/material.dart';

/// Gestão do size da tela\
/// Para forçar uma resposta para o `isWeb` coloque este valor no `isWebForce`
class PageSize {
  late BuildContext context;
  late double widthDefault;
  bool? isWebForce;
  PageSize(this.context, {this.widthDefault = 395, this.isWebForce});

  bool get isWeb {
    if (isWebForce != null) return isWebForce!;
    if (Theme.of(context).platform == TargetPlatform.android || Theme.of(context).platform == TargetPlatform.iOS) {
      return false;
    }
    return true;
  }

  double get height {
    return MediaQuery.of(context).size.height;
  }

  double get width {
    if (!isWeb) return MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).size.width > widthDefault) return widthDefault;
    return MediaQuery.of(context).size.width;
  }

  double get aspectRatio {
    return MediaQuery.of(context).size.aspectRatio;
  }

  double get shortestSide {
    if (MediaQuery.of(context).size.shortestSide == MediaQuery.of(context).size.width) {
      return width;
    } else {
      return height;
    }
  }

  double get longestSide {
    if (MediaQuery.of(context).size.longestSide == MediaQuery.of(context).size.width) {
      return width;
    } else {
      return height;
    }
  }

  double get pHeight => height / 100;
  double get pWidth => width / 100;
  double get pShortestSide => shortestSide / 100;
  double get pLongestSide => longestSide / 100;
}
