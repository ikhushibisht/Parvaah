import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parvaah_helping_hand/src/constants/image_string.dart';
import 'package:parvaah_helping_hand/src/constants/sizes.dart';
import 'package:parvaah_helping_hand/src/constants/text_string.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  String getBackgroundImage(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark
        ? tDarkModeBackground
        : tLightModeBackground;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(getBackgroundImage(context)),
            fit: BoxFit.cover, // Cover the whole screen
          ),
        ),
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tOtpTitle,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 80.0),
            ),
            Text(tOtpSubTitle.toUpperCase(),
                style: TextStyle(
                  fontSize: 25.0,
                  color: isDarkMode
                      ? const Color.fromARGB(255, 204, 152, 252)
                      : Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 40.0),
            const Text("$tOtpMessage the provided Email Id",
                textAlign: TextAlign.center),
            const SizedBox(height: 20.0),
            OtpTextField(
                mainAxisAlignment: MainAxisAlignment.center,
                numberOfFields: 6,
                fillColor: Colors.black.withOpacity(0.4),
                filled: true,
                onSubmit: (code) => print("OTP is => $code")),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: const Text(tNext)),
            ),
          ],
        ),
      ),
    );
  }
}
