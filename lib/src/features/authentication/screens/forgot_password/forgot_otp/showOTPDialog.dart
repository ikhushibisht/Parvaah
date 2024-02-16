import 'package:flutter/material.dart';
import 'package:parvaah_helping_hand/src/constants/text_string.dart';

void showOTPDialog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("$tOtpMessage the provided Phone No.",
          textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: codeController,
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(onPressed: onPressed, child: const Text(tDone)),
      ],
    ),
  );
}
