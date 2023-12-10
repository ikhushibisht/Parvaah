import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parvaah_helping_hand/src/constants/image_string.dart';
import 'package:parvaah_helping_hand/src/constants/sizes.dart';
import 'package:parvaah_helping_hand/src/constants/text_string.dart';
import 'package:parvaah_helping_hand/src/features/authentication/controllers/splash_controller.dart';

import '../../../../constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashScreenController = Get.put(SplashScreenController());

  @override
  void initState() {
    super.initState();
    splashScreenController.startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              top: splashScreenController.animate.value ? -50 : 0,
              left: splashScreenController.animate.value ? 0 : 0,
              bottom: splashScreenController.animate.value ? 0 : 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: splashScreenController.animate.value ? 0.47 : 0,
                child: const Image(image: AssetImage(tSplashImage)),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 3000),
              top: 370, // Adjusted to the center
              left: splashScreenController.animate.value ? tDefaultSize : 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tAppName,
                    style: TextStyle(
                      fontSize: 40.0,
                      color: isDarkMode
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : tPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    tAppTagLine,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: isDarkMode ? Colors.yellowAccent : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
