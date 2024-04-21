import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parvaah_helping_hand/src/features/authentication/screens/org_dash/sponsorDetails.dart';

class Getupdates extends StatelessWidget {
  const Getupdates({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? tAccentColor : tDashboardBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150), // Set the preferred height
        child: _CustomAppBar(isDarkMode: isDarkMode, appBarTitle: 'Updates'),
      ),
      body: Container(
        color: isDarkMode ? tAccentColor : tDashboardBg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Sponsorships',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _buildSponsorDetails(context),
            ),
            const SizedBox(height: 20),
            const Text(
              'Donations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _buildPaymentUpdates(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSponsorDetails(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 190, 227, 194),
        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
      ),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('sponsors').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No sponsor details available.'),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var sponsor = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DisplaySponsorDetailsScreen(sponsor: sponsor),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 245, 242, 242),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${sponsor['name']}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'By: ${sponsor['sponsored_by']}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPaymentUpdates(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 233, 211, 178),
        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
      ),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('payments').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No payment updates available.'),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var payment = snapshot.data!.docs[index];
              return Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 242, 242),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cause: ${payment['title']}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Amount: ${payment['amount']}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'By: ${payment['fullName']}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final bool isDarkMode;
  final String appBarTitle;

  const _CustomAppBar(
      {Key? key, required this.isDarkMode, required this.appBarTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? tPrimaryColor : tBgColor,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20), // Adjust the radius as needed
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: 28,
            toolbarHeight: 150,
            elevation: 0,
            title: Column(
              children: [
                Text(
                  appBarTitle,
                  style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 233, 233),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black87,
                      ),
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
        ],
      ),
    );
  }
}
