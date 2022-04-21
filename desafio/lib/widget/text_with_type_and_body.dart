import 'package:flutter/material.dart';

class TextWithTypeAndBody extends Text {
  final String type;
  final String body;

  TextWithTypeAndBody(
    this.type,
    this.body, {
    Key? key,
    int? maxLines,
    TextOverflow? overflow,
  }) : super.rich(
          TextSpan(text: type + ': ', children: <InlineSpan>[
            TextSpan(
              text: body,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ]),
          maxLines: maxLines,
          overflow: overflow,
          key: key,
        );
}
