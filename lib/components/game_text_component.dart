import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// A class extends the normal TextComponent, to include
// ability to set a tap callback and utilize a google font.

// This class could be expanded to include much more functionality,
// but the basics are provided here.
class GameTextComponent extends TextComponent with TapCallbacks {
  GameTextComponent({
    required super.text,
    required super.position,
    super.priority,
    super.anchor,
    super.angle,
    super.scale,
    super.size,
    this.fontSize = 20,
    this.tapCallback,
    this.color = Colors.white,
    this.fontWeight = FontWeight.w500,
    this.shadowOffset = const Offset(3.0, 3.0),
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
  Function? tapCallback;
  Offset shadowOffset;

  @override
  void onTapDown(TapDownEvent event) {
    tapCallback?.call(this);
    super.onTapDown(event);
  }
}
