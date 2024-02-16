import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parvaah_helping_hand/src/constants/sizes.dart';
import 'package:parvaah_helping_hand/src/constants/text_string.dart';
import 'package:parvaah_helping_hand/src/features/authentication/services/firebase_auth_methods.dart';

class SignUpFormWidget extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpFormWidgetState createState() => _SignUpFormWidgetState();
}

final TextEditingController fullNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUpUser() async {
    FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    // Define a list of user types including "-Select-"
    List<String> userTypes = [
      '-Select-',
      'Admin',
      'Contributor',
      'Organization',
    ];

    // Declare a variable to store the selected user type
    String selectedUserType = '-Select-';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 30),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: tFullName,
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
            ),
            const SizedBox(height: tFormHeight - 40),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: tEmail,
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: tFormHeight - 40),
            TextFormField(
              decoration: const InputDecoration(
                labelText: tPhoneNo,
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: tFormHeight - 40),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: tPassword,
                prefixIcon: Icon(Icons.fingerprint),
              ),
            ),
            const SizedBox(height: tFormHeight - 40),
            // Dropdown selection for user type
            DropdownButtonFormField(
              value: selectedUserType,
              items: userTypes.map((String userType) {
                return DropdownMenuItem(
                  value: userType,
                  child: Text(userType),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  // Update the selected user type
                  selectedUserType = value;
                }
              },
              decoration: const InputDecoration(
                labelText: 'User Type',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: tFormHeight - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: signUpUser,
                child: const Text(tSignup),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
