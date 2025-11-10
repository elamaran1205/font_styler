import 'package:flutter/material.dart';

import 'package:font_styler/Controller/style_controller.dart';
import 'package:font_styler/utils/my_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget styleSizeButtons() {
  final controller = Get.find<StyleController>();
  return Obx(
    () => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 15,
      children: [
        SizedBox(
          width: 150,
          child: DropdownButton<String>(
            isExpanded: true,
            padding: EdgeInsets.all(10),
            underline: SizedBox.shrink(),
            value: controller.selectedFont.value,
            items: controller.font.map((font) {
              return DropdownMenuItem(
                value: font,
                child: Text(
                  font,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.getFont(font),
                ),
              );
            }).toList(),
            onChanged: (value) {
              controller.saveState();
              if (value != null) controller.changeFont(value);
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: MyColors.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Center(
                child: IconButton(
                  onPressed: () {
                    if (controller.fontSize.value != 1.0) {
                      controller.saveState();
                      controller.fontSize.value -= 1;
                    }
                  },
                  icon: Icon(Icons.remove, color: MyColors.primaryBlue),
                ),
              ),
              Text(
                controller.fontSize.value.toString().split(".").first,
                style: TextStyle(color: MyColors.primaryBlack),
              ),
              Center(
                child: IconButton(
                  onPressed: () {
                    controller.saveState();
                    controller.fontSize.value += 1;
                  },
                  icon: Icon(Icons.add, color: MyColors.primaryBlue),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
