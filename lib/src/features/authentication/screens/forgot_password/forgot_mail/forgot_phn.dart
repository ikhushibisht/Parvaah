import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:parvaah_helping_hand/src/common_w/form/form_header.dart';
import 'package:parvaah_helping_hand/src/constants/image_string.dart';
import 'package:parvaah_helping_hand/src/constants/sizes.dart';
import 'package:parvaah_helping_hand/src/constants/text_string.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/forgot_password/forgot_otp/otp2.dart';

class ForgotPasswordPhoneScreen extends StatelessWidget {
  const ForgotPasswordPhoneScreen({
    Key? key,
  }) : super(key: key);

  String getBackgroundImage(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark
        ? tDarkModeBackground
        : tLightModeBackground;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(getBackgroundImage(context)),
                fit: BoxFit.cover, // Cover the whole screen
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 70),
                FormHeaderWidget(
                  image: tForgotPasswordImage,
                  title: tForgotPassword.toUpperCase(),
                  subTitle: tUsingPhoneNo,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 40.0,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: tFormHeight),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text(tPhoneNo),
                          hintText: tPhoneNo,
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => const OTPScreen1());
                          },
                          child: const Text(tNext),
                        ),
                      ),
                      const SizedBox(
                          height: 300.0), // Add spacing below the button
                      // Add additional widgets below the button if needed
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
