import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';
import 'package:parvaah_helping_hand/src/constants/image_string.dart';
import 'package:parvaah_helping_hand/src/constants/sizes.dart';
import 'package:parvaah_helping_hand/src/constants/text_string.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/login/login_screen.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/signup/signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoginSelected = true;

  String getBackgroundImage() {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark
        ? tDarkModeBackground
        : tLightModeBackground;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          Colors.transparent, // Set background color to transparent
      body: Stack(
        children: [
          // Background Image with Blur Effect
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2,
              sigmaY: 2,
            ), // Adjust sigma values for blur intensity
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    getBackgroundImage(),
                  ), // Use dynamic background image
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white
                        .withOpacity(0.2), // Adjust opacity for lighter color
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(tSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  fit: BoxFit.none,
                  alignment: Alignment.center,
                  image: const AssetImage(tWelcomeScreen),
                  height: height * 0.6,
                ),
                Column(
                  children: [
                    Text(
                      tWelcomeTitle,
                      style: TextStyle(
                        fontSize: 30.0,
                        color: isDarkMode
                            ? tSecondaryColor
                            : const Color.fromARGB(255, 37, 4, 57),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      tWelcomeSubtitle,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: isDarkMode
                            ? tSecondaryColor
                            : const Color.fromARGB(255, 17, 4, 24),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: isLoginSelected
                          ? ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isLoginSelected = true;
                                });
                                Get.to(() => const LoginScreen());
                              },
                              child: Text(tLogin.toUpperCase()),
                            )
                          : OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  isLoginSelected = true;
                                });
                                Get.to(() => const LoginScreen());
                              },
                              child: Text(tLogin.toUpperCase()),
                            ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: isLoginSelected
                          ? OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  isLoginSelected = false;
                                });
                                Get.to(() => const SignUpScreen());
                              },
                              child: Text(tSignup.toUpperCase()),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isLoginSelected = false;
                                });
                                Get.to(() => const SignUpScreen());
                              },
                              child: Text(tSignup.toUpperCase()),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
