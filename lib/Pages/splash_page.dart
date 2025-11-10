import 'package:flutter/material.dart';
import 'package:font_styler/Pages/home_page.dart';
import 'package:font_styler/utils/my_colors.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "FONT STYLER",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: MyColors.primaryBlack,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Simple controls, smooth editing, endless creativity.",
                style: TextStyle(fontSize: 15, color: MyColors.secondaryBlack),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () => Get.offAll(() => HomePage()),
                child: Container(
                  width: 150,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyColors.primaryBlue,
                  ),
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(color: MyColors.surface),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
