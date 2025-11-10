import 'package:flutter/material.dart';
import 'package:font_styler/Controller/style_controller.dart';
import 'package:font_styler/utils/my_colors.dart';
import 'package:get/get.dart';

Widget textStyleComponent() {
  final controller = Get.find<StyleController>();
  return Container(
    width: 300,
    decoration: BoxDecoration(
      color: MyColors.background,
      boxShadow: [
        BoxShadow(
          blurRadius: 1,
          spreadRadius: 0.5,
          offset: Offset(0.5, 0.8),
          color: MyColors.secondaryBlack.withOpacity(0.6),
        ),
      ],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          TextButton(
            onPressed: () {
              controller.saveState();
              controller.isBold.value = !controller.isBold.value;
            },
            style: TextButton.styleFrom(backgroundColor: MyColors.background),
            child: Text(
              "B",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: controller.isBold.value
                    ? MyColors.primaryBlue
                    : MyColors.primaryBlack,
                fontSize: 20,
              ),
            ),
          ),

          TextButton(
            onPressed: () {
              controller.saveState();
              controller.isItalic.value = !controller.isItalic.value;
            },
            style: TextButton.styleFrom(backgroundColor: MyColors.background),
            child: Text(
              "I",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal,
                color: controller.isItalic.value
                    ? MyColors.primaryBlue
                    : MyColors.primaryBlack,
                fontSize: 20,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              controller.saveState();
              controller.toggleTextAlign();
            },
            child: Icon(
              controller.alignIcon.value,
              color: MyColors.primaryBlue,
            ),
          ),
          TextButton(
            onPressed: () {
              controller.saveState();
              controller.underLine.value = !controller.underLine.value;
            },

            child: Text(
              "U",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.underline,
                decorationColor: controller.underLine.value
                    ? MyColors.primaryBlue
                    : MyColors.secondaryBlack,
                color: controller.underLine.value
                    ? MyColors.primaryBlue
                    : MyColors.secondaryBlack,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
