import 'package:flutter/material.dart';
import 'package:parvaah_helping_hand/src/constants/sizes.dart';
import 'package:parvaah_helping_hand/src/constants/text_string.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/forgot_password/forgot_options/forgot_pass_model.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isPasswordVisible = false;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: tFormHeight - 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: tEmail,
                  hintText: tEmail,
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: tFormHeight - 45),
            TextFormField(
              obscureText: !_isPasswordVisible,
              controller: _passwordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                labelText: tPassword,
                hintText: tPassword,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.remove_red_eye_outlined,
                  ),
                ),
              ),
            ),
            const SizedBox(height: tFormHeight - 50),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  ForgotPasswordScreen.buildShowModalBottomSheet(
                      context, isDarkMode);
                },
                child: const Text(tForgotPassword),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Access password using _passwordController.text
                },
                child: const Text(tLogin),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
