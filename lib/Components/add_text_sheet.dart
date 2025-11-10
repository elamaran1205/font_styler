import 'package:flutter/material.dart';
import 'package:font_styler/Controller/style_controller.dart';
import 'package:get/get.dart';
import '../utils/my_colors.dart';

void showAddTextSheet() {
  final controller = Get.find<StyleController>();
  final addText = TextEditingController();

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Add New Text",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: MyColors.primaryBlack,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          TextField(
            controller: addText,
            decoration: InputDecoration(
              hintText: "Enter your text here",
              hintStyle: TextStyle(
                color: MyColors.secondaryBlack.withOpacity(0.5),
              ),
              filled: true,
              fillColor: MyColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                controller.addtext(addText.text.trim());
                controller.saveState();
                Get.back();
              },
              style: TextButton.styleFrom(
                backgroundColor: MyColors.primaryBlue,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Add Text",
                style: TextStyle(
                  color: MyColors.surface,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
