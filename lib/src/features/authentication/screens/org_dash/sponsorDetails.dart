import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';

class DisplaySponsorDetailsScreen extends StatelessWidget {
  final DocumentSnapshot sponsor;

  const DisplaySponsorDetailsScreen({Key? key, required this.sponsor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? tAccentColor : tDashboardBg,
      appBar: AppBar(
        backgroundColor: isDarkMode ? tPrimaryColor : tBgColor,
        title: const Text(
          'Sponsorship',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(90.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                sponsor['image_url'],
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
              Text(
                'Name: ${sponsor['name']}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Age: ${sponsor['age']}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 10),
              Text(
                'Gender: ${sponsor['sex']}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 10),
              Text(
                'Address: ${sponsor['address']}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 10),
              Text(
                'City: ${sponsor['city']}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 10),
              Text(
                'State: ${sponsor['state']}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 10),
              Text(
                'Pincode: ${sponsor['pincode']}',
                style: const TextStyle(fontSize: 1),
              ),
              const SizedBox(height: 10),
              Text(
                'Sponsored by: ${sponsor['sponsored_by']}',
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
