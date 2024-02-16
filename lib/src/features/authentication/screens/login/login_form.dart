import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parvaah_helping_hand/src/constants/sizes.dart';
import 'package:parvaah_helping_hand/src/constants/text_string.dart';
import 'package:parvaah_helping_hand/src/features/authentication/services/firebase_auth_methods.dart';

class LoginForm extends StatefulWidget {
  static String routeName = '/login-email-phone';
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  String? emailOrPhoneError;
  String? passwordError;

  @override
  void dispose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() {
    String emailOrPhone = emailOrPhoneController.text.trim();

    // Validate whether email or phone is provided
    if (emailOrPhone.isEmpty) {
      setState(() {
        emailOrPhoneError = "This field cannot be empty";
      });
      return;
    } else {
      emailOrPhoneError = null;
    }

    if (passwordController.text.isEmpty) {
      setState(() {
        passwordError = "This field cannot be empty";
      });
      return;
    } else {
      passwordError = null;
    }

    // Check if the input is in the form of an email
    if (emailOrPhone.contains('@')) {
      // Email and Password login
      FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
        email: emailOrPhone,
        password: passwordController.text,
        context: context,
      );
    } else {
      // Phone login
      FirebaseAuthMethods(FirebaseAuth.instance)
          .phoneSignIn(context, emailOrPhone);
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: tFormHeight - 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: emailOrPhoneController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: tEmailPhone,
                hintText: tEmailPhone,
                border: OutlineInputBorder(),
                errorText: emailOrPhoneError,
              ),
            ),
            const SizedBox(height: tFormHeight - 30),
            TextFormField(
              controller: passwordController,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                labelText: tPassword,
                hintText: tPassword,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.remove_red_eye_outlined,
                  ),
                ),
                errorText: passwordError,
              ),
            ),
            const SizedBox(height: tFormHeight - 30),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(tForgotPassword),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loginUser,
                child: const Text(tLogin),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
