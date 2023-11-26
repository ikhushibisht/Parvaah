import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';
import 'package:parvaah_helping_hand/src/constants/sizes.dart';
import 'package:parvaah_helping_hand/src/constants/text_string.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/forgot_password/forgot_mail/forgot_mail.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/forgot_password/forgot_mail/forgot_phn.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/forgot_password/forgot_options/forgot_pass_widget.dart';

class ForgotPasswordScreen {
  static Future<dynamic> buildShowModalBottomSheet(
      BuildContext context, bool isDarkMode) {
    return showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        context: context,
        builder: (context) => Container(
              padding: const EdgeInsets.all(tDefaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tForgotPasswordTitle,
                      style: TextStyle(
                          fontSize: 27.0,
                          color: isDarkMode
                              ? const Color.fromARGB(255, 255, 255, 255)
                              : tPrimaryColor,
                          fontWeight: FontWeight.bold)),
                  Text(
                    tForgotPasswordSubTitle,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: isDarkMode ? Colors.amber : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 35.0),
                  ForgotPassBtn(
                    isDarkMode: isDarkMode,
                    btnIcon: Icons.mail_outline_rounded,
                    title: tEmail,
                    subTitle: tResetViaEmail,
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(() => const ForgotPasswordMailScreen());
                    },
                  ),
                  const SizedBox(height: 15.0),
                  ForgotPassBtn(
                    isDarkMode: isDarkMode,
                    btnIcon: Icons.mobile_friendly_rounded,
                    title: tPhoneNo,
                    subTitle: tResetViaPhone,
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(() => const ForgotPasswordPhoneScreen());
                    },
                  ),
                ],
              ),
            ));
  }
}
