import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';
import 'package:parvaah_helping_hand/src/constants/image_string.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/contri_dash/donation_dashboard/payment.dart';

class RecoveryScreen extends StatefulWidget {
  const RecoveryScreen({Key? key}) : super(key: key);

  @override
  _RecoveryScreenState createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends State<RecoveryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  double totalAmount = 100000.0; // Set the total amount to be raised
  double collectedAmount = 60000.0; // Set the collected amount initially

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Make the animation loop with reverse
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _startAnimation() async {
    try {
      await _animationController.forward(from: 0.0);
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Disaster Recovery',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : tPrimaryColor,
            ),
          ),
          backgroundColor: isDarkMode ? tPrimaryColor : tBgColor,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Display image with text and total amount
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 400,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                                tDisaster), // Assuming you have this image in your project

                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(
                                0.5), // Adjust the opacity as needed
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Total Amount: \₹${totalAmount.toString()}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Text about the importance of education
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Turning disaster into determination',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : tPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.justify,
                          'Disasters, whether natural or human-made, can inflict profound and widespread damage to communities, economies, and environments. They can result in loss of life, displacement of populations, destruction of infrastructure, disruption of essential services, and economic upheaval. Your donation can help in various ways.',
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                isDarkMode ? Colors.yellowAccent : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.to(() => const PaymentScreen());
                    },
                    icon: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _animationController.value * 2.0 * 3.14,
                          child: Icon(
                            Icons.monetization_on,
                            size: 36,
                            color: isDarkMode ? Colors.white : tPrimaryColor,
                          ),
                        );
                      },
                    ),
                    label: Text(
                      'DONATE',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : tPrimaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // LinearProgressIndicator for funds collected
                  LinearProgressIndicator(
                    value: collectedAmount / totalAmount,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isDarkMode ? tSecondaryColor : tPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Text showing the amount collected
                  Text(
                    'Collected: \₹${collectedAmount.toString()}',
                    style: TextStyle(
                      fontSize: 17,
                      color: isDarkMode ? Colors.white : tPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: tDashboardBg,
      ),
    );
  }
}
