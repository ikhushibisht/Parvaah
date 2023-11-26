import 'package:flutter/material.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';

class ForgotPassBtn extends StatelessWidget {
  const ForgotPassBtn({
    required this.btnIcon,
    required this.title,
    required this.subTitle,
    super.key,
    required this.isDarkMode,
    required this.onTap,
  });
  final IconData btnIcon;
  final String title, subTitle;
  final bool isDarkMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: isDarkMode
                ? const Color.fromARGB(255, 91, 89, 89)
                : const Color.fromARGB(255, 195, 191, 191)),
        child: Row(
          children: [
            Icon(btnIcon, size: 40.0),
            const SizedBox(width: 11.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 23.0,
                        color: isDarkMode ? tThirdColor : Colors.black,
                        fontWeight: FontWeight.bold)),
                Text(subTitle,
                    style: TextStyle(
                        fontSize: 15.0,
                        color: isDarkMode
                            ? Colors.white
                            : const Color.fromARGB(255, 56, 56, 56),
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
