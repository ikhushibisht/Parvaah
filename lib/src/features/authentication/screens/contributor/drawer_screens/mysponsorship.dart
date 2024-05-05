import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';

class SponsorshipDetailsPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? tAccentColor : tDashboardBg,
      appBar: AppBar(
        title: Text(
          'My sponsorships',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : tPrimaryColor,
          ),
        ),
      ),
      body: FutureBuilder<User?>(
        future: _getCurrentUser(),
        builder: (context, AsyncSnapshot<User?> userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (userSnapshot.hasError || userSnapshot.data == null) {
            return Center(child: Text('Error: User not authenticated'));
          }
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('sponsorship')
                .where('sponsored_by',
                    isEqualTo: userSnapshot.data!.displayName ?? '')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No sponsorship details found.'));
              }
              // Print document data for debugging
              snapshot.data!.docs.forEach((doc) {
                print(doc.data());
              });
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  // Print data for debugging
                  print('Name: ${data['name']}');
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(
                        data['name'] ?? '',
                        style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black),
                      ),
                      subtitle: Text(
                          'Age: ${data['age'] ?? ''}, Amount: ${data['amount'] ?? ''}'),
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  Future<User?> _getCurrentUser() async {
    return _auth.currentUser;
  }
}
