import 'package:flutter/material.dart';
import 'package:font_styler/Components/add_text_sheet.dart';
import 'package:font_styler/Components/size%20_style_buttons.dart';
import 'package:font_styler/Components/style_component_buttons.dart';
import 'package:font_styler/Controller/style_controller.dart';
import 'package:font_styler/utils/my_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(StyleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTextSheet,
        backgroundColor: MyColors.primaryBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: MyColors.primaryBlue,
        elevation: 2,
        title: Text(
          "Font Styler",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: MyColors.surface,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            color: MyColors.background,
            tooltip: "How to use",
            onPressed: showUsageDialog,
          ),
        ],
      ),
      backgroundColor: MyColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // undo and redo widget
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myTextButton(
                  () => controller.undo(),
                  "Undo",
                  Icons.undo,
                  Colors.transparent,
                ),
                myTextButton(
                  () => controller.redo(),
                  "Redo",
                  Icons.redo,
                  Colors.transparent,
                ),
              ],
            ),
            // undo and redo widget
            const SizedBox(height: 25),
            // CANVAS text editor
            Center(
              child: Container(
                height: 320,
                width: 300,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: MyColors.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Obx(() {
                  final pos = controller.textPosition.value;
                  return Stack(
                    children: [
                      Positioned(
                        left: pos.dx,
                        top: pos.dy,
                        child: GestureDetector(
                          onPanStart: (details) => controller.saveState(),
                          onPanUpdate: (details) {
                            controller.updatePosition(
                              Offset(
                                pos.dx + details.delta.dx,
                                pos.dy + details.delta.dy,
                              ),
                            );
                            controller.saveState();
                          },
                          child: Text(
                            controller.textAddedorNot.value
                                ? controller.addedText.value
                                : "",
                            style: GoogleFonts.getFont(
                              controller.selectedFont.value,
                              textStyle: TextStyle(
                                fontSize: controller.fontSize.value,
                                fontWeight: controller.isBold.value
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontStyle: controller.isItalic.value
                                    ? FontStyle.italic
                                    : FontStyle.normal,
                                decoration: controller.underLine.value
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                                color: MyColors.primaryBlack,
                              ),
                            ),
                            textAlign: controller.textAlign.value,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            // CANVAS text editor
            const SizedBox(height: 30),
            // FONT STYLE AND FONT SIZE BUTTONS
            styleSizeButtons(),

            const SizedBox(height: 20),
            // other styling attributes
            textStyleComponent(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

Widget myTextButton(
  VoidCallback ontap,
  String txt,
  IconData icon,
  Color color,
) {
  return TextButton.icon(
    onPressed: ontap,
    icon: Icon(icon, color: MyColors.primaryBlue, size: 20),
    label: Text(
      txt,
      style: TextStyle(
        color: MyColors.primaryBlack,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
    style: TextButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}

void showUsageDialog() {
  Get.dialog(
    Center(
      child: Material(
        color: Colors.transparent,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 360,
            maxHeight: Get.height * 0.5,
          ),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: MyColors.surface,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.lightbulb, size: 28),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "How to use Font Styler",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: MyColors.primaryBlack,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        instructionItem("Tap the + button to add your text."),
                        instructionItem(
                          "Use the toolbar to toggle Bold / Italic / Underline.",
                        ),
                        instructionItem("Pick fonts from the dropdown"),
                        instructionItem(
                          "Use + / - or slider to change font size.",
                        ),
                        instructionItem(
                          "Tap the align icon to cycle Left → Center → Right.",
                        ),
                        instructionItem(
                          "Long press and drag the text to move it inside the canvas.",
                        ),
                        instructionItem(
                          "Use Undo / Redo to step back and forward (state history).",
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Tip: Text stays inside the box. If it goes out, press Left Align ",
                          style: TextStyle(
                            fontSize: 13,
                            color: MyColors.secondaryBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    barrierDismissible: true,
  );
}

Widget instructionItem(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 3),
          child: Icon(Icons.check_circle_outline, size: 18),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    ),
  );
}
