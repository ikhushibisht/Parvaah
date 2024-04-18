import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OneScreen extends StatefulWidget {
  final String postId; // Add a parameter to receive the post ID
  const OneScreen({Key? key, required this.postId}) : super(key: key);

  @override
  _OneScreenState createState() => _OneScreenState();
}

class _OneScreenState extends State<OneScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  String title = '';
  String subtitle = '';
  String causeDetails = '';
  String imageUrl = '';
  double totalAmount = 0.0;
  double collectedAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Make the animation loop with reverse

    // Fetch data from Firestore based on the selected post ID
    _fetchDataFromFirestore();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Fetch data from Firestore based on the selected post ID
  Future<void> _fetchDataFromFirestore() async {
    try {
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .get();

      if (documentSnapshot.exists) {
        // Update state with fetched data
        setState(() {
          title = documentSnapshot['title'];
          totalAmount = documentSnapshot['totalAmount'];
          collectedAmount = documentSnapshot['collectedAmount'];
          subtitle = documentSnapshot['subtitle'];
          causeDetails = documentSnapshot['causeDetails'];
          imageUrl = documentSnapshot['imageURL'];
        });
      }
    } catch (e) {
      // Handle errors
      print('Error fetching data: $e');
    }
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
            title, // Use the fetched subtitle
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
                          image: imageUrl.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(
                                      imageUrl), // Use NetworkImage directly
                                  fit: BoxFit.cover,
                                )
                              : null, // Set to null if imageUrl is empty
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
                          subtitle, // Use the fetched subtitle
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : tPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          causeDetails, // Use the fetched cause details
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
                  GestureDetector(
                    onTap: () {
                      InAppWebView(
                        initialData: InAppWebViewInitialData(
                          data: '''
        <html>
          <form>
            <script src="https://checkout.razorpay.com/v1/payment-button.js" data-payment_button_id="pl_NznGUEqEUBSjms" async></script>
          </form>
        </html>
      ''',
                          baseUrl: WebUri('https://checkout.razorpay.com'),
                        ),
                      );
                    },
                    child: Image.network(
                      'https://checkout.razorpay.com/v1/payment-button.js?payment_button_id=pl_NznGUEqEUBSjms',
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          // If the image has finished loading, return the image widget
                          return child;
                        } else {
                          // If the image is still loading, you can return a loading indicator or placeholder
                          return CircularProgressIndicator(); // Example of using a CircularProgressIndicator
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 10),
                  // LinearProgressIndicator for funds collected
                  LinearProgressIndicator(
                    value: collectedAmount,
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
