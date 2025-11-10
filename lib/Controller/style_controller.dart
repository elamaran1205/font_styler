import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_styler/Components/font_list.dart';
import 'package:font_styler/Model/undo_redo_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleController extends GetxController {
  ////////
  var addedText = "".obs;
  var textAddedorNot = false.obs;
  ///////

  var selectedFont = 'Roboto'.obs;
  var fontSize = 15.0.obs;
  var isBold = false.obs;
  var isItalic = false.obs;
  var textAlign = TextAlign.left.obs;
  var alignIcon = Icons.format_align_left.obs;
  var underLine = false.obs;
  ////////
  var textPosition = Offset(100, 100).obs;
  //////
  final font = FontList.fonts;
  void addtext(String text) {
    addedText.value = text;
    textAddedorNot.value = true;
  }

  void updatePosition(Offset newPos) {
    textPosition.value = newPos;
  }

  void changeFont(String fontName) {
    selectedFont.value = fontName;
  }

  double measureTextWidth(String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: GoogleFonts.getFont(
          selectedFont.value,
          textStyle: TextStyle(fontSize: fontSize.value),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  double containerWidth = 300;
  double containerHeight = 320;
  void toggleTextAlign() {
    final text = addedText.value.isEmpty ? "Sample" : addedText.value;
    final textWidth = measureTextWidth(text);
    const padding = 16.0;

    if (textAlign.value == TextAlign.left) {
      textAlign.value = TextAlign.center;
      alignIcon.value = Icons.format_align_center;

      textPosition.value = Offset(
        (containerWidth / 2) - (textWidth / 2),
        textPosition.value.dy,
      );
    } else if (textAlign.value == TextAlign.center) {
      textAlign.value = TextAlign.right;
      alignIcon.value = Icons.format_align_right;

      textPosition.value = Offset(
        containerWidth - textWidth - padding,
        textPosition.value.dy,
      );
    } else {
      textAlign.value = TextAlign.left;
      alignIcon.value = Icons.format_align_left;
      textPosition.value = Offset(padding, textPosition.value.dy);
    }
  }

  // for Undo - Redo flow

  final undoStack = <TextState>[].obs;
  final redoStack = <TextState>[].obs;

  void saveState() {
    undoStack.add(
      TextState(
        text: addedText.value,
        fontSize: fontSize.value,
        isBold: isBold.value,
        isItalic: isItalic.value,
        isUnderline: underLine.value,
        fontFamily: selectedFont.value,
        align: textAlign.value,
        position: textPosition.value,
      ),
    );
    redoStack.clear();
  }

  void undo() {
    if (undoStack.isEmpty) return;
    final lastState = undoStack.removeLast();
    redoStack.add(currentState());
    applyState(lastState);
  }

  void redo() {
    if (redoStack.isEmpty) return;
    final nextState = redoStack.removeLast();
    undoStack.add(currentState());
    applyState(nextState);
  }

  void applyState(TextState state) {
    addedText.value = state.text;
    fontSize.value = state.fontSize;
    isBold.value = state.isBold;
    isItalic.value = state.isItalic;
    underLine.value = state.isUnderline;
    selectedFont.value = state.fontFamily;
    textAlign.value = state.align;
    textPosition.value = state.position;
  }

  TextState currentState() => TextState(
    text: addedText.value,
    fontSize: fontSize.value,
    isBold: isBold.value,
    isItalic: isItalic.value,
    isUnderline: underLine.value,
    fontFamily: selectedFont.value,
    align: textAlign.value,
    position: textPosition.value,
  );
}
