import 'package:flutter/material.dart';
import 'package:parvaah_helping_hand/src/common_w/form/form_header.dart';
import 'package:parvaah_helping_hand/src/constants/image_string.dart';
import 'package:parvaah_helping_hand/src/constants/sizes.dart';
import 'package:parvaah_helping_hand/src/constants/text_string.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/login/login_footer.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
            padding: const EdgeInsets.all(tDefaultSize),
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(getBackgroundImage(context)), // Pass the context
                fit: BoxFit.cover,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHeaderWidget(
                  image: tWelcomeScreen,
                  title: tLoginTitle,
                  subTitle: tLoginSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 30.0,
                  textAlign: TextAlign.center,
                ),
                LoginForm(),
                LoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
