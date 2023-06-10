import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class OverflowTitle extends StatelessWidget {
  final String text;
  final TextStyle titleStyle;

  const OverflowTitle({required this.text, this.titleStyle=const TextStyle(fontSize: 30, fontWeight: FontWeight.bold,)});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final textSpan = TextSpan(text: text, style: titleStyle);
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          maxLines: 1,
        );
        textPainter.layout(maxWidth: constraints.maxWidth);

        if (textPainter.didExceedMaxLines) {
          return SizedBox(
            height: 40,
            child: Marquee(
              text: text,
              style: titleStyle,
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20,
              velocity: 100,
              pauseAfterRound: Duration(seconds: 1),
              accelerationDuration: Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          );
        } else {
          return Text(
            text,
            style: titleStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        }
      },
    );
  }
}