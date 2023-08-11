import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StandardGameText extends TextComponent with Tappable {
  StandardGameText({
    required super.text,
    required super.position,
    super.priority,
    super.anchor,
    super.angle,
    super.scale,
    super.size,
    this.fontSize = 20,
    this.touchCallback,
    this.color = Colors.white,
    this.fontWeight = FontWeight.w500,
    this.shadowOffset = const Offset(5.0, 5.0),
  }) {
    textRenderer = TextPaint(
      style: GoogleFonts.rockSalt(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: 1.2,
        shadows: [
          Shadow(
            color: BasicPalette.black.color,
            offset: shadowOffset,
            blurRadius: 3.0,
          )
        ],
      ),
    );
  }

  Color color;
  double fontSize;
  FontWeight fontWeight;
  Function? touchCallback;
  Offset shadowOffset;

  @override
  bool onTapDown(TapDownInfo info) {
    if (touchCallback != null) {
      touchCallback!();
      return true;
    }
    return false;
  }
}
