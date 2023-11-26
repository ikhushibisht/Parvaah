import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parvaah_helping_hand/src/constants/sizes.dart';
import 'package:parvaah_helping_hand/src/constants/text_string.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define a list of user types including "-Select-"
    List<String> userTypes = [
      '-Select-',
      'Contributor',
      'Organization',
      'Admin'
    ];

    // Declare a variable to store the selected user type
    String selectedUserType = userTypes[0]; // Default to "-Select-"

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 45),
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
            const SizedBox(height: tFormHeight - 45),
            TextFormField(
              decoration: const InputDecoration(
                labelText: tEmail,
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: tFormHeight - 45),
            TextFormField(
              decoration: const InputDecoration(
                labelText: tPhoneNo,
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: tFormHeight - 45),
            TextFormField(
              decoration: const InputDecoration(
                labelText: tPassword,
                prefixIcon: Icon(Icons.fingerprint),
              ),
            ),
            const SizedBox(height: tFormHeight - 45),
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
            const SizedBox(height: tFormHeight - 27),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Check if a valid user type is selected
                  if (selectedUserType != '-Select-') {
                    // Access the selected user type using the variable 'selectedUserType'
                    if (kDebugMode) {
                      print('Selected User Type: $selectedUserType');
                    }
                  } else {
                    // Handle the case where "-Select-" is chosen
                    if (kDebugMode) {
                      print('Please select a valid user type');
                    }
                  }
                },
                child: const Text(tSignup),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
