import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wattio_frontend/helpers/math_helper.dart';
import 'package:intl/intl.dart' as intl;
import 'package:wattio_frontend/helpers/screen_helper.dart';
import 'package:wattio_frontend/styles/colors.dart';
import 'package:wattio_frontend/widgets/slider/background_slider_painter.dart';
import 'package:wattio_frontend/widgets/slider/slider_painter.dart';

// ignore: must_be_immutable
class CircularSlider extends StatefulWidget {
  CircularSlider({
    Key? key,
    required this.minValue,
    required this.startAngle,
    required this.onChanged,
  }) : super(key: key);
  final int minValue;
  double startAngle;

  final Function(int) onChanged;

  @override
  State<CircularSlider> createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider> {
  MathHelper mathHelper = MathHelper();
  Offset _dragOffset = Offset.zero;
  double sweep = 0.0;
  late int actualValue;
  late Offset handlerPosition;
  late Offset center;
  intl.NumberFormat nbformat = intl.NumberFormat('#,###.00', 'pt-BR');
  @override
  void initState() {
    super.initState();
    actualValue = widget.minValue.toInt();
  }

  @override
  Widget build(BuildContext context) {
    ScreenHelper screen = ScreenHelper(context: context);
    return screen.isBiggerScreen
        ? Slider(
            value: actualValue.toDouble(),
            onChanged: (value) {
              actualValue = value.toInt();
              widget.onChanged(value.toInt());
              setState(() {});
            },
            min: double.parse(
              widget.minValue.toString(),
            ),
            max: 100000.0,
            thumbColor: AppColors.yellowPrimary,
            activeColor: AppColors.bluePrimary,
            divisions: 99,
            label: '$actualValue',
          )
        : LayoutBuilder(builder: (context, constraints) {
            double startInRadians = mathHelper.toRadian(widget.startAngle);
            double backgroundRadius = 160;
            center = Offset(
              constraints.maxWidth / 2,
              screen.height * .6 / 2,
            );
            handlerPosition = (center - const Offset(60, 60)) +
                Offset.fromDirection(
                  sweep + startInRadians,
                  backgroundRadius,
                );
            return Stack(clipBehavior: Clip.hardEdge, children: [
              CustomPaint(
                size: Size(screen.width, 0),
                painter: BackgroundSliderPainter(
                  center: center,
                  backgroundRadius: backgroundRadius,
                  sweep: sweep,
                  start: startInRadians,
                  text: 'R\$\n ${nbformat.format(actualValue)}',
                ),
              ),
              Positioned(
                  top: handlerPosition.dy,
                  left: handlerPosition.dx,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onPanDown: (details) {
                      RenderBox renderHandler =
                          context.findRenderObject() as RenderBox;
                      _dragOffset =
                          renderHandler.globalToLocal(details.globalPosition);
                    },
                    onPanUpdate: (details) {
                      Offset previousOffset = _dragOffset;
                      _dragOffset += details.delta;
                      double newAngle = sweep +
                          mathHelper.toAngle(_dragOffset, center) -
                          mathHelper.toAngle(previousOffset, center);
                      sweep = mathHelper.normalizeAngle(newAngle);
                      int percentage = (sweep / (2 * pi) * 100).toInt();
                      // actualValue = widget.minValue * (1 + percentage);
                      actualValue =
                          (widget.minValue * (1 + percentage).toInt());
                      widget.onChanged(actualValue);
                      setState(() {});
                    },
                    child: const SliderHandler(),
                  ))
            ]);
          });
  }
}
