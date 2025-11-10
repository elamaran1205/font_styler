import 'package:flutter/material.dart';

class TextState {
  String text;
  double fontSize;
  bool isBold;
  bool isItalic;
  bool isUnderline;
  String fontFamily;
  TextAlign align;
  Offset position;

  TextState({
    required this.text,
    required this.fontSize,
    required this.isBold,
    required this.isItalic,
    required this.isUnderline,
    required this.fontFamily,
    required this.align,
    required this.position,
  });

  TextState copy() => TextState(
    text: text,
    fontSize: fontSize,
    isBold: isBold,
    isItalic: isItalic,
    isUnderline: isUnderline,
    fontFamily: fontFamily,
    align: align,
    position: position,
  );
}
