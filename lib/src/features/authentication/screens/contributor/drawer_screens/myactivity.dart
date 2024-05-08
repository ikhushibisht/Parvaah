import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';

class MyActivityScreen extends StatefulWidget {
  final String userId;

  const MyActivityScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _MyActivityScreenState createState() => _MyActivityScreenState();
}

class _MyActivityScreenState extends State<MyActivityScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? tAccentColor : tDashboardBg,
      appBar: AppBar(
        title: Text(
          'Sponsor a Person',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : tPrimaryColor,
          ),
        ),
        backgroundColor: isDarkMode ? tPrimaryColor : tBgColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('payments')
            .where('userId', isEqualTo: widget.userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data!.docs;
          if (documents.isEmpty) {
            return const Center(
              child: Text('No donations made yet.'),
            );
          }
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final payment = documents[index];
              return DonationListItem(paymentId: payment.id);
            },
          );
        },
      ),
    );
  }
}

class DonationListItem extends StatelessWidget {
  final String paymentId;

  const DonationListItem({Key? key, required this.paymentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .doc(paymentId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final post = snapshot.data!;
        return ListTile(
          title: const Text('Donation'),
          subtitle: Text(post['title']),
          // You can add more details of the donation here
          // For example: amount donated, date, etc.
        );
      },
    );
  }
}
