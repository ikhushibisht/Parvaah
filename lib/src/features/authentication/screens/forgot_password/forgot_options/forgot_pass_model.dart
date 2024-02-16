// import 'package:flutter/material.dart';
// import 'package:parvaah_helping_hand/src/constants/colors.dart';
// import 'package:parvaah_helping_hand/src/constants/image_string.dart';
// import 'package:parvaah_helping_hand/src/constants/sizes.dart';
// import 'package:parvaah_helping_hand/src/constants/text_string.dart';
// import 'package:parvaah_helping_hand/src/features/authentication/screens/forgot_password/forgot_options/forgot_pass_widget.dart';

// class ForgotPasswordScreen {
//   static Future<dynamic> buildShowModalBottomSheet(
//       BuildContext context, bool isDarkMode) {
//     return showModalBottomSheet(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
//       context: context,
//       builder: (context) => Container(
//         padding: const EdgeInsets.all(tDefaultSize),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.0), // Set border radius here
//           image: DecorationImage(
//             image: AssetImage(
//               isDarkMode ? tDarkModeBackground : tLightModeBackground,
//             ),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 40.0),
//             Text(
//               tForgotPasswordTitle,
//               style: TextStyle(
//                 fontSize: 27.0,
//                 color: isDarkMode
//                     ? const Color.fromARGB(255, 255, 255, 255)
//                     : tPrimaryColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 25.0),
//             ForgotPassBtn(
//               isDarkMode: isDarkMode,
//               btnIcon: Icons.mobile_friendly_rounded,
//               title: tPhoneNo,
//               subTitle: tResetViaPhone,
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
